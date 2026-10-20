#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Gera o relatório comparativo de desempenho do SO Mancha (T2).

O script:
- Testa sete configurações de escalonamento.
- Recompila o sistema para cada configuração.
- Executa as simulações com limite de instruções.
- Extrai as métricas e os relatórios individuais.
- Gera RELATORIO.md com apresentação organizada e análise comparativa.
- Restaura o arquivo so.h e recompila a configuração original ao terminar.
"""

import os
import re
import subprocess
from datetime import datetime


# ============================================================
# CONFIGURAÇÕES
# ============================================================

CONFIGURACOES = [
    {
        "nome": "Escalonador Simples",
        "descricao": "Cooperativo",
        "escalonador": "ESC_SIMPLES",
        "quantum": 4,
    },
    {
        "nome": "Round-Robin",
        "descricao": "Quantum de 2 tiques",
        "escalonador": "ESC_CIRCULAR",
        "quantum": 2,
    },
    {
        "nome": "Round-Robin",
        "descricao": "Quantum de 4 tiques",
        "escalonador": "ESC_CIRCULAR",
        "quantum": 4,
    },
    {
        "nome": "Round-Robin",
        "descricao": "Quantum de 8 tiques",
        "escalonador": "ESC_CIRCULAR",
        "quantum": 8,
    },
    {
        "nome": "Prioridade Dinâmica",
        "descricao": "Quantum de 2 tiques",
        "escalonador": "ESC_PRIORIDADE",
        "quantum": 2,
    },
    {
        "nome": "Prioridade Dinâmica",
        "descricao": "Quantum de 4 tiques",
        "escalonador": "ESC_PRIORIDADE",
        "quantum": 4,
    },
    {
        "nome": "Prioridade Dinâmica",
        "descricao": "Quantum de 8 tiques",
        "escalonador": "ESC_PRIORIDADE",
        "quantum": 8,
    },
]

LIMITE_INSTRUCOES = "15000000"
ENTRADA_SIMULACAO = "X"

DIRETORIO = os.path.dirname(os.path.abspath(__file__))
CAMINHO_SO_H = os.path.join(DIRETORIO, "so.h")
CAMINHO_RELATORIO = os.path.join(DIRETORIO, "RELATORIO.md")


# ============================================================
# EXECUÇÃO DE COMANDOS
# ============================================================

def executar_comando(comando, *, silencioso=False, verificar=True):
    """Executa um comando dentro do diretório do projeto."""

    if silencioso:
        resultado = subprocess.run(
            comando,
            cwd=DIRETORIO,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.PIPE,
            text=True,
            check=False,
        )
    else:
        resultado = subprocess.run(
            comando,
            cwd=DIRETORIO,
            capture_output=True,
            text=True,
            check=False,
        )

    if verificar and resultado.returncode != 0:
        detalhes = resultado.stderr.strip() if resultado.stderr else ""

        raise RuntimeError(
            f"Falha ao executar: {' '.join(comando)}\n{detalhes}"
        )

    return resultado


def compilar_projeto():
    """Limpa e recompila o projeto."""

    executar_comando(
        ["make", "clean"],
        silencioso=True,
    )

    executar_comando(
        ["make"],
        silencioso=True,
    )


# ============================================================
# CONFIGURAÇÃO DO ESCALONADOR
# ============================================================

def configurar_so(conteudo_original, configuracao):
    """Atualiza as macros do escalonador e do quantum em so.h."""

    conteudo = re.sub(
        r"(?m)^(\s*#define\s+CONFIG_ESCALONADOR\s+)\w+",
        lambda m: f"{m.group(1)}{configuracao['escalonador']}",
        conteudo_original,
        count=1,
    )

    conteudo, substituicoes_quantum = re.subn(
        r"(?m)^(\s*#define\s+CONFIG_QUANTUM\s+)\w+",
        lambda m: f"{m.group(1)}{configuracao['quantum']}",
        conteudo,
        count=1,
    )

    if conteudo == conteudo_original:
        if configuracao["escalonador"] not in conteudo_original:
            raise RuntimeError(
                "Não foi possível localizar CONFIG_ESCALONADOR em so.h."
            )

    if substituicoes_quantum != 1:
        raise RuntimeError(
            "Não foi possível atualizar CONFIG_QUANTUM em so.h."
        )

    if not re.search(
        r"(?m)^\s*#define\s+CONFIG_ESCALONADOR\s+"
        + re.escape(configuracao["escalonador"])
        + r"\b",
        conteudo,
    ):
        raise RuntimeError(
            "Não foi possível atualizar CONFIG_ESCALONADOR em so.h."
        )

    return conteudo


# ============================================================
# EXTRAÇÃO DE MÉTRICAS
# ============================================================

def extrair_numero(texto, padrao):
    """Extrai um valor numérico usando uma expressão regular."""

    correspondencia = re.search(padrao, texto, re.IGNORECASE)

    if correspondencia:
        return correspondencia.group(1)

    return None


def extrair_relatorio(saida):
    """Localiza o relatório de execução impresso pelo simulador."""

    marcador = "RELATORIO DE EXECUCAO DO SO"
    posicao = saida.find(marcador)

    if posicao == -1:
        return "Relatório de execução não encontrado na saída da simulação."

    inicio = max(0, posicao - 41)
    texto = saida[inicio:].strip()

    fim_caixa = texto.rfind("========================================")

    if fim_caixa != -1:
        texto = texto[:fim_caixa + 40]

    return texto.strip()


def executar_simulacao(configuracao):
    """Compila e executa uma configuração de escalonamento."""

    print(
        f"  [EXECUTANDO] {configuracao['nome']} — "
        f"{configuracao['descricao']}"
    )

    with open(CAMINHO_SO_H, "r", encoding="utf-8") as arquivo:
        conteudo_atual = arquivo.read()

    conteudo_configurado = configurar_so(
        conteudo_atual,
        configuracao,
    )

    with open(CAMINHO_SO_H, "w", encoding="utf-8") as arquivo:
        arquivo.write(conteudo_configurado)

    compilar_projeto()

    comando = [
        "./sim_batch",
        "so.mob",
        LIMITE_INSTRUCOES,
        ENTRADA_SIMULACAO,
    ]

    resultado = executar_comando(
        comando,
        verificar=False,
    )

    saida_completa = resultado.stdout or ""
    saida_erro = resultado.stderr or ""

    relatorio = extrair_relatorio(saida_completa)

    if resultado.returncode != 0:
        relatorio += (
            "\n\nA simulação terminou com código de erro "
            f"{resultado.returncode}."
        )

        if saida_erro.strip():
            relatorio += "\n\nSaída de erro:\n" + saida_erro.strip()

    elif "não encontrado" in relatorio.lower():
        relatorio += (
            "\n\nA saída completa da simulação não foi descartada; "
            "consulte o campo de saída original nos resultados "
            "ou verifique o formato do relatório emitido pelo simulador."
        )

    texto_metricas = relatorio + "\n" + saida_completa

    return {
        "configuracao": configuracao.copy(),
        "relatorio": relatorio,
        "saida_completa": saida_completa,
        "codigo_retorno": resultado.returncode,
        "tempo_total": extrair_numero(
            texto_metricas,
            r"Tempo total exec:\s*(\d+)",
        ),
        "preempcoes": extrair_numero(
            texto_metricas,
            r"Total preempcoes:\s*(\d+)",
        ),
        "syscalls": extrair_numero(
            texto_metricas,
            r"Syscalls:\s*(\d+)",
        ),
        "sucesso": (
            resultado.returncode == 0
            and "não encontrado" not in relatorio.lower()
        ),
    }


# ============================================================
# FORMATAÇÃO DO RELATÓRIO
# ============================================================

def formatar_numero(valor):
    """Formata valores numéricos com separador de milhares."""

    if valor is None:
        return "—"

    try:
        return f"{int(valor):,}".replace(",", ".")
    except (ValueError, TypeError):
        return str(valor)


def nome_configuracao(configuracao):
    """Monta o nome completo da configuração."""

    return f"{configuracao['nome']} — {configuracao['descricao']}"


def gerar_resumo(resultados):
    """Cria a tabela comparativa de métricas."""

    linhas = [
        "| Configuração | Escalonador | Quantum | "
        "Tempo total (tiques) | Preempções | Syscalls | Resultado |",
        "|---|---|---:|---:|---:|---:|---|",
    ]

    for resultado in resultados:
        configuracao = resultado["configuracao"]

        status = "Concluído" if resultado["sucesso"] else "Verificar"

        quantum = (
            "—"
            if configuracao["escalonador"] == "ESC_SIMPLES"
            else str(configuracao["quantum"])
        )

        linhas.append(
            f"| {nome_configuracao(configuracao)} "
            f"| `{configuracao['escalonador']}` "
            f"| {quantum} "
            f"| {formatar_numero(resultado['tempo_total'])} "
            f"| {formatar_numero(resultado['preempcoes'])} "
            f"| {formatar_numero(resultado['syscalls'])} "
            f"| {status} |"
        )

    return "\n".join(linhas)


def gerar_detalhes(resultados):
    """Organiza os relatórios individuais em seções expansíveis."""

    secoes = []

    for indice, resultado in enumerate(resultados, start=1):
        configuracao = resultado["configuracao"]

        status = "Concluído" if resultado["sucesso"] else "Verificar"

        secoes.append(
            f"### {indice:02d}. {nome_configuracao(configuracao)}\n\n"
            f"- **Política:** `{configuracao['escalonador']}`\n"
            f"- **Quantum configurado:** {configuracao['quantum']} tique(s)\n"
            f"- **Estado da execução:** {status}\n\n"
            "<details>\n"
            "<summary>Exibir relatório original da simulação</summary>\n\n"
            "```text\n"
            f"{resultado['relatorio'].replace('```', '` ` `')}\n"
            "```\n\n"
            "</details>"
        )

    return "\n\n".join(secoes)


def gerar_analise(resultados):
    """Gera a análise conceitual das políticas testadas."""

    simples = next(
        (
            r for r in resultados
            if r["configuracao"]["escalonador"] == "ESC_SIMPLES"
        ),
        None,
    )

    circulares = [
        r for r in resultados
        if r["configuracao"]["escalonador"] == "ESC_CIRCULAR"
    ]

    prioridades = [
        r for r in resultados
        if r["configuracao"]["escalonador"] == "ESC_PRIORIDADE"
    ]

    linhas = [
        "## Interpretação dos resultados",
        "",
        "### 1. Escalonamento cooperativo",
        "",
        "O escalonador simples não realiza preempções por quantum. "
        "Um processo mantém a CPU até terminar voluntariamente ou "
        "bloquear, por exemplo, ao executar `SO_LE` ou `SO_ESPERA_PROC`.",
        "",
        "Essa abordagem reduz o custo associado às trocas de contexto, "
        "mas pode prejudicar a capacidade de resposta quando um processo "
        "mantém a CPU ocupada por muito tempo.",
        "",
        "### 2. Escalonamento Round-Robin",
        "",
        "O Round-Robin distribui a CPU entre processos prontos por meio "
        "de fatias de tempo. Um quantum menor tende a aumentar a frequência "
        "de preempções; um quantum maior tende a reduzir a quantidade de "
        "trocas de contexto, mas pode aumentar o tempo de espera.",
        "",
    ]

    if circulares:
        validos = [
            r for r in circulares
            if r["preempcoes"] is not None
            and r["tempo_total"] is not None
        ]

        if validos:
            menor_quantum = min(
                validos,
                key=lambda r: int(r["configuracao"]["quantum"]),
            )
            maior_quantum = max(
                validos,
                key=lambda r: int(r["configuracao"]["quantum"]),
            )

            linhas.extend([
                f"Nas medições obtidas, o quantum de "
                f"**{menor_quantum['configuracao']['quantum']}** apresentou "
                f"{formatar_numero(menor_quantum['preempcoes'])} preempções, "
                "enquanto o quantum de "
                f"**{maior_quantum['configuracao']['quantum']}** apresentou "
                f"{formatar_numero(maior_quantum['preempcoes'])}.",
                "",
            ])

    linhas.extend([
        "### 3. Escalonamento por prioridade dinâmica",
        "",
        "A prioridade dinâmica é recalculada conforme o comportamento "
        "do processo, utilizando a fórmula:",
        "",
        r"$$\mathrm{prio} = \frac{\mathrm{prio} + "
        r"t_{\mathrm{exec}}/t_{\mathrm{quantum}}}{2}$$",
        "",
        "Quanto menor o valor numérico da prioridade, maior a prioridade "
        "de escalonamento. Processos limitados por entrada e saída "
        "(I/O-bound), que bloqueiam antes de consumir todo o quantum, "
        "podem obter prioridade mais favorável.",
        "",
        "Essa política busca melhorar a responsividade de processos "
        "interativos, embora o resultado dependa da carga de trabalho "
        "e dos parâmetros utilizados.",
        "",
        "### 4. Comparação geral",
        "",
        "| Política | Vantagem | Limitação |",
        "|---|---|---|",
        "| Cooperativo | Menor sobrecarga de preempção | Pode prejudicar a responsividade |",
        "| Round-Robin | Compartilhamento circular da CPU | Resultado depende do quantum |",
        "| Prioridade dinâmica | Adaptação ao comportamento dos processos | Depende do cálculo e da evolução das prioridades |",
        "",
        "> **Nota:** as conclusões quantitativas devem ser interpretadas "
        "com base nos valores efetivamente obtidos na tabela comparativa. "
        "Execuções sem métricas completas devem ser verificadas antes "
        "de qualquer conclusão de desempenho.",
    ])

    if simples and not simples["sucesso"]:
        linhas.extend([
            "",
            "> **Atenção:** a execução do escalonador cooperativo não "
            "produziu um relatório reconhecido pelo script.",
        ])

    if prioridades and not all(r["sucesso"] for r in prioridades):
        linhas.extend([
            "",
            "> **Atenção:** uma ou mais execuções por prioridade dinâmica "
            "não produziram um relatório reconhecido pelo script.",
        ])

    return "\n".join(linhas)


def montar_relatorio(resultados):
    """Monta o documento Markdown completo."""

    data_geracao = datetime.now().strftime("%d/%m/%Y às %H:%M:%S")

    return f"""<div align="center">

# Relatório de Desempenho
## Sistema Operacional Mancha — T2

**Avaliação comparativa dos escalonadores**

`ESC_SIMPLES` · `ESC_CIRCULAR` · `ESC_PRIORIDADE`

</div>

---

## Sobre este relatório

Este documento apresenta os resultados dos testes do mini sistema operacional Mancha em sete configurações de escalonamento, variando a política e o tamanho do quantum.

O objetivo é comparar o comportamento dos escalonadores, observar métricas de execução e documentar os relatórios produzidos pelo simulador, conforme a avaliação da Parte III do trabalho.

| Parâmetro | Valor |
|---|---|
| Configurações testadas | {len(resultados)} |
| Limite de instruções por simulação | {formatar_numero(LIMITE_INSTRUCOES)} |
| Entrada fornecida ao simulador | `{ENTRADA_SIMULACAO}` |
| Data de geração | {data_geracao} |

## 01 — Visão geral dos resultados

{gerar_resumo(resultados)}

**Como interpretar:** o tempo total é expresso em tiques; preempções indicam interrupções da execução corrente para troca de processo; syscalls representam chamadas de sistema contabilizadas pelo simulador.

O símbolo `—` indica que o valor não foi identificado automaticamente na saída da simulação. Ele não representa necessariamente zero.

---

## 02 — Configurações avaliadas

| Nº | Política | Quantum |
|---:|---|---:|
| 1 | Escalonador simples (cooperativo) | 4 — não utilizado como quantum |
| 2 | Round-Robin circular | 2 tiques |
| 3 | Round-Robin circular | 4 tiques |
| 4 | Round-Robin circular | 8 tiques |
| 5 | Prioridade dinâmica | 2 tiques |
| 6 | Prioridade dinâmica | 4 tiques |
| 7 | Prioridade dinâmica | 8 tiques |

No Round-Robin e no escalonador por prioridade dinâmica, o quantum determina a duração da fatia de CPU antes da possibilidade de preempção. No modo cooperativo, o quantum não controla a alternância entre processos.

---

## 03 — Relatórios individuais

A seção a seguir preserva a saída do relatório identificada para cada configuração, permitindo verificar os valores individuais e comparar as execuções.

{gerar_detalhes(resultados)}

---

## 04 — Análise dos resultados

{gerar_analise(resultados)}

---

## 05 — Metodologia

O script realiza as seguintes etapas para cada configuração:

1. Atualiza as macros `CONFIG_ESCALONADOR` e `CONFIG_QUANTUM` em `so.h`.
2. Executa `make clean` para remover os artefatos anteriores.
3. Executa `make` para recompilar o sistema com a configuração selecionada.
4. Inicia `sim_batch` com o arquivo `so.mob`, o limite de instruções e a entrada definida.
5. Extrai o relatório da saída da simulação e identifica as métricas disponíveis.
6. Reúne os resultados em uma tabela comparativa e em seções individuais.

Ao final, o conteúdo original de `so.h` é restaurado e o projeto é recompilado com essa configuração original.

### Limitações da coleta

- As métricas são extraídas por padrões de texto presentes na saída do simulador.
- Caso o formato do relatório seja alterado, alguns valores podem não ser identificados.
- Uma execução que não apresente o marcador do relatório deve ser investigada antes de ser considerada válida.
- O limite de instruções é de {formatar_numero(LIMITE_INSTRUCOES)} por simulação.

---

<div align="center">

**Sistemas Operacionais · Trabalho 2**

*Mini sistema operacional multiprogramado sobre a arquitetura Mancha*

</div>
"""


# ============================================================
# FLUXO PRINCIPAL
# ============================================================

def main():
    print("=" * 64)
    print(" RELATÓRIO DE DESEMPENHO — SO MANCHA (T2)")
    print("=" * 64)

    if not os.path.isfile(CAMINHO_SO_H):
        raise FileNotFoundError(
            f"Arquivo não encontrado: {CAMINHO_SO_H}"
        )

    with open(CAMINHO_SO_H, "r", encoding="utf-8") as arquivo:
        conteudo_original = arquivo.read()

    resultados = []

    try:
        for configuracao in CONFIGURACOES:
            resultado = executar_simulacao(configuracao)
            resultados.append(resultado)

            status = "OK" if resultado["sucesso"] else "VERIFICAR"

            print(
                f"  [{status}] "
                f"Tempo: {formatar_numero(resultado['tempo_total'])} | "
                f"Preempções: {formatar_numero(resultado['preempcoes'])} | "
                f"Syscalls: {formatar_numero(resultado['syscalls'])}"
            )

    finally:
        print("\nRestaurando a configuração original de so.h...")

        with open(CAMINHO_SO_H, "w", encoding="utf-8") as arquivo:
            arquivo.write(conteudo_original)

        print("Recompilando a configuração original...")

        try:
            compilar_projeto()
        except Exception as erro:
            print(f"AVISO: não foi possível recompilar a configuração original: {erro}")

    conteudo_relatorio = montar_relatorio(resultados)

    with open(CAMINHO_RELATORIO, "w", encoding="utf-8") as arquivo:
        arquivo.write(conteudo_relatorio)

    concluidos = sum(1 for r in resultados if r["sucesso"])

    print("\n" + "=" * 64)
    print(" RELATÓRIO GERADO")
    print("=" * 64)
    print(f"Arquivo: {CAMINHO_RELATORIO}")
    print(f"Configurações executadas: {len(resultados)}")
    print(f"Relatórios identificados: {concluidos}")
    print(f"Execuções para verificar: {len(resultados) - concluidos}")
    print("=" * 64)


if __name__ == "__main__":
    main()