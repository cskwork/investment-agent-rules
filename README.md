# Ten Commandments for AI Investment Agents

**English** | [한국어](README.ko.md)

A minimal, drop-in rule set for any AI agent that proposes, sizes, or executes trades — distilled from the people who paid for the lessons:

Buffett, Munger, Graham, Lynch, Dalio, Marks, Soros, Druckenmiller, Simons, Greenblatt.

Ten rules. One overlay for the Korean market. One enforcement map for quant bots. No fluff.

## Why

LLM-driven trading agents fail in predictable ways:

- They size every signal the same, regardless of conviction or regime.
- They follow the consensus and call it research.
- They take a "good thesis" as license to ignore the price.
- They "average down" into permanent losses because the narrative still fits.
- They confuse a lucky outcome with a working process.
- They mistake 30 correlated names for a diversified book.
- They edit their own risk rules mid-session to make a loss look like a strategy.
- They claim a backtested edge without an out-of-sample period.

The Ten Commandments below — plus the *Korean Equity Overlay* and the *Quant-Bot Enforcement Map* — block all of those.

## Install

### One-liner (recommended)

```bash
git clone https://github.com/cskwork/investment-agent-rules.git ~/investment-agent-rules
cd ~/investment-agent-rules && ./install.sh
```

Files land in `~/.claude/rules/investment/`. Reference them from your project's `CLAUDE.md` / `AGENTS.md`:

```markdown
@~/.claude/rules/investment/common/00-index.md
@~/.claude/rules/investment/kr-equity/00-kr-equity-overlay.md
@~/.claude/rules/investment/quant-bot/00-bot-enforcement.md
```

### Selective install

```bash
./install.sh common      # only the ten commandments
./install.sh kr-equity   # only the Korean-market overlay
./install.sh quant-bot   # only the bot-enforcement map
```

### Custom destination

```bash
INVESTMENT_RULES_DEST=~/my/path ./install.sh
```

## The Ten Commandments

1. **Capital Preservation First.** Never permanent loss. A 50% drawdown takes a 100% gain to break even. — *Buffett, Rule No. 1*
2. **Margin of Safety.** Buy below intrinsic value; the gap absorbs the part of your model that turns out to be wrong. — *Graham, Buffett*
3. **Circle of Competence.** Trade only what you can explain. The whitelist is the bot's circle. "I don't know" is a valid action. — *Buffett, Lynch*
4. **Second-Level Thinking.** Consensus is in the price. Edge lives in the gap between what is true and what is believed. Invert. — *Marks, Munger*
5. **Cycles and Reflexivity.** Markets feed back on themselves. Size *down* in euphoria, not up. — *Marks, Soros*
6. **Position Sizing and Asymmetric Risk-Reward.** Size from the stop distance, not the lot size. Demand 2:1 or no trade. — *Druckenmiller*
7. **Concentration in Conviction, Diversification in Ignorance.** Both are correct. Correlated names are not diversification. — *Buffett, Dalio*
8. **Long-term Compounding Over Short-term Trading.** Most leaks are turnover, not bad picks. No signal, no trade. — *Buffett, Munger*
9. **Process Over Outcome.** Validate signals out-of-sample, log everything, judge the process — not last week's P&L. — *Simons, Greenblatt*
10. **Behavioral Discipline.** Mr. Market panics; the bot does not. No rule edits in a live session. The kill switch is a feature. — *Graham, Munger*

Full text and per-rule checklists live under [`rules/common/`](rules/common/00-index.md). Each rule ends with a *How an AI trading bot enforces this* section — pseudocode for the gate that turns the principle into deterministic code.

## Repository Layout

```
investment-agent-rules/
├── README.md
├── README.ko.md
├── LICENSE                       # MIT
├── install.sh                    # copies rules/ to ~/.claude/rules/investment/
└── rules/
    ├── common/                   # the ten commandments (one file each)
    │   ├── 00-index.md
    │   ├── 01-capital-preservation.md
    │   ├── 02-margin-of-safety.md
    │   ├── 03-circle-of-competence.md
    │   ├── 04-second-level-thinking.md
    │   ├── 05-cycles-and-reflexivity.md
    │   ├── 06-position-sizing-and-asymmetry.md
    │   ├── 07-concentration-vs-diversification.md
    │   ├── 08-long-term-compounding.md
    │   ├── 09-process-over-outcome.md
    │   └── 10-behavioral-discipline.md
    ├── kr-equity/                # Korean market specifics
    │   └── 00-kr-equity-overlay.md
    └── quant-bot/                # commandment → gate mapping for bots
        └── 00-bot-enforcement.md
```

## Design Notes

- **Imperative, not advisory.** Each rule is a directive and a gate, not a value statement.
- **Pseudocode where it matters.** Principles are easy to nod at and hard to enforce. Each commandment ends with the gate that enforces it.
- **Market-agnostic core + market-specific overlay.** The ten rules apply anywhere; the KR overlay encodes what is different about Korean cash equities (taxes, settlement, auctions, VI).
- **LLM proposes, code disposes.** The quant-bot overlay assumes an LLM is in the loop and is unsafe by default. The gates are the safety.
- **No tool names in the core.** No `pandas`, no `ccxt`, no specific broker. The principles outlive any one stack.

## Companion Project

This rule set is what disciplines [`kr-ai-trader`](https://github.com/cskwork/kr-ai-trader), an AI-driven Korean-equity trading bot. The rules came first, the code came second — by design.

## Customizing

Fork. Edit `rules/common/` last; edit the overlays and the enforcement map first.

A new rule must:
- Be one sentence at the top, with a checklist and a code gate below.
- Map to a real failure mode someone has paid for.
- Not duplicate an existing rule.

If your fork grows past fifteen commandments, you have a textbook, not a rule set.

## Disclaimer

Educational reference only. Not investment advice. Markets can and will find ways to lose money that this document does not anticipate. The author is not your fiduciary.

## License

MIT. See [LICENSE](LICENSE).
