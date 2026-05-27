# Ten Commandments for AI Investment Agents

**English** | [한국어](README.ko.md)

Landing page: **https://cskwork.github.io/investment-agent-rules/**

A minimal, drop-in rule set for any AI agent that researches, proposes, sizes, or executes long-term investment positions — distilled from the people who paid for the lessons:

**Graham, Buffett, Munger, Fisher, Lynch, Marks, Bogle, Malkiel.**

Ten rules. One overlay for the Korean market. One enforcement map. No fluff.

## One-sentence conclusion

> Great investing is preserving capital first, then buying understandable, high-quality assets below intrinsic value with a margin of safety, holding them long enough to compound, controlling emotion and costs along the way — and, when none of that genuinely applies, defaulting to low-cost, broad, diversified ownership.

## Why

LLM-driven investment agents fail in predictable ways:

- They optimize for return before they have proven they cannot permanently lose the capital.
- They confuse a rising price with rising value.
- They build a "thesis" by stacking peer multiples and recent narrative.
- They mistake comfort with a name for circle-of-competence.
- They buy the spreadsheet without verifying that management lets shareholders see the cash.
- They define risk as volatility, then size positions that force selling at the bottom.
- They follow the consensus more confidently because it is recent.
- They claim an edge they have not earned across a cycle.
- They cannot bring themselves to say "you don't have an edge — buy the index."

The Ten Commandments below — plus the *Korean Equity Overlay* and the *Investment Agent Enforcement Map* — block all of those.

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
./install.sh quant-bot   # only the agent-enforcement map
```

### Custom destination

```bash
INVESTMENT_RULES_DEST=~/my/path ./install.sh
```

## The Ten Commandments

1. **Capital Preservation First.** Never permanent loss. A 50% drawdown takes a 100% gain to break even. Capital preservation is the umbrella goal; every other rule is a technique that serves it. The relevant kind of loss is *permanent* impairment, not volatility — but volatility becomes permanent loss if the position is sized so the investor is forced to sell. — *Buffett (Rule No. 1), Marks*
2. **Buy Value, Not Price.** Start from "what can this earn?" The price sets the discount; it is not the argument. — *Graham, Marks*
3. **Demand a Margin of Safety.** Pay enough below intrinsic value that being wrong is survivable. The noisier the input, the wider the margin. — *Graham, Buffett*
4. **A Stock Is a Piece of a Business.** Would you buy the whole company at this implied valuation? If not, do not buy a share of it either. — *Buffett (Owner's Manual)*
5. **Stay in Your Circle of Competence.** Only own what you can explain in one paragraph: revenue, customers, competition, destructors. "I don't know" is a valid action. — *Buffett, Lynch*
6. **Quality at a Fair Price Beats Mediocrity at a Discount.** Durable moat, high ROIC across cycles, pricing power, long reinvestment runway. Cheap is the floor; quality is the multiplier. — *Fisher, Buffett, Munger*
7. **Verify Management and Capital Allocation.** Owners decide what happens to the cash. Look at insider ownership, buyback prices, acquisition track record, dilution, debt discipline, shareholder communication. — *Buffett*
8. **Compound Long-Term; Don't Get in the Way.** Sell only when the thesis is broken, the quality is broken, or a clearly better opportunity exists. Time is not a signal. — *Munger, Buffett*
9. **Use Cycles and Crowd Psychology Against Themselves.** Second-level thinking: the consensus is already in the price. Size down in euphoria; look hardest at quality assets in panic. — *Marks, Soros, Buffett*
10. **Without a Real Edge, Default to Low-Cost Diversification.** Edge — informational, analytical, or behavioral — must be earned, not assumed. If it is absent, broad, low-cost, long-held index ownership is the honest answer. — *Bogle, Malkiel*

Full text and per-rule checklists with deterministic gates live under [`rules/common/`](rules/common/00-index.md). Each rule ends with *How an AI investment agent enforces this* — pseudocode for the gate that turns the principle into deterministic code.

## The five that matter most

If only five rules survive, these are load-bearing:

- **Rule 1** — capital preservation (the umbrella goal).
- **Rule 2** — value, not price.
- **Rule 3** — margin of safety.
- **Rule 4** — stock is a business.
- **Rule 10** — default to indexing if no edge.

The other five — circle of competence, quality, management, compounding, cycles — are the operating system that turns those five into action.

## 10 questions before any position

1. What is the **written permanent-loss scenario** for this position, and can I survive it?
2. Can I explain in one paragraph how this business makes money?
3. Is the price meaningfully below my estimate of intrinsic value?
4. If my estimate is 20–30% too high, am I still protected?
5. Am I willing to hold this for five years or more?
6. Is there a durable competitive advantage that a competitor cannot easily replicate?
7. Does management think and allocate capital like a long-term owner?
8. Is my reason to buy analysis, or is it crowd participation in disguise?
9. Is the position sized so I can hold through a 30–50% drawdown without selling?
10. Do I genuinely have an edge here, or is broad low-cost diversification the more honest answer?

## Repository Layout

```
investment-agent-rules/
├── README.md
├── README.ko.md
├── LICENSE                       # MIT
├── install.sh                    # copies rules/ to ~/.claude/rules/investment/
└── rules/
    ├── common/                                       # the ten commandments
    │   ├── 00-index.md
    │   ├── 01-capital-preservation.md
    │   ├── 02-buy-value-not-price.md
    │   ├── 03-margin-of-safety.md
    │   ├── 04-stock-is-a-business.md
    │   ├── 05-circle-of-competence.md
    │   ├── 06-quality-at-fair-price.md
    │   ├── 07-management-and-capital-allocation.md
    │   ├── 08-long-term-compounding.md
    │   ├── 09-cycles-and-crowd-psychology.md
    │   └── 10-default-to-low-cost-diversification.md
    ├── kr-equity/                                    # Korean-market specifics
    │   └── 00-kr-equity-overlay.md
    └── quant-bot/                                    # commandment → gate mapping
        └── 00-bot-enforcement.md
```

## Design Notes

- **Imperative, not advisory.** Each rule is a directive and a gate, not a value statement.
- **Pseudocode where it matters.** Principles are easy to nod at and hard to enforce. Each commandment ends with the gate that enforces it.
- **Capital preservation is the umbrella, not just another rule.** Rule 1 names the goal; the other nine are the techniques that defend it. Margin of safety, position sizing, diversification, cycle awareness all exist because permanent loss is the only thing the agent absolutely cannot recover from.
- **Permanent loss, not volatility.** The Marks refinement is embedded directly in Rule 1: drops in price with intact earnings are not risk events; they only become risk if the position is sized to force selling.
- **Investing first, trading second.** Earlier versions emphasized per-trade discipline (stop distances, position sizing from stop, kill switches). This version emphasizes ownership-grade investing — value, business quality, management, compounding — with trading discipline as a supporting layer, not the core.
- **Edge honesty is a first-class rule.** Most investors do not have a durable edge. Rule 10 turns that uncomfortable truth into a default behavior, not a disclaimer.
- **Market-agnostic core + market-specific overlay.** The ten rules apply anywhere; the KR overlay encodes what is different about Korean cash equities (taxes, settlement, auctions, VI, KSD).
- **LLM proposes, code disposes.** The enforcement map assumes an LLM is in the loop and unsafe by default. The gates are the safety.

## References

The rules are distilled from repeated patterns across these sources:

- Benjamin Graham, *The Intelligent Investor* — margin of safety, investor vs speculator, Mr. Market.
- Warren Buffett, Berkshire Hathaway *Owner's Manual* and the annual shareholder letters — Rule No. 1, stocks as pieces of businesses, intrinsic value, management capital allocation.
- Charlie Munger, *Poor Charlie's Almanack* — multi-disciplinary mental models, inversion, do-not-interrupt-compounding.
- Philip Fisher, *Common Stocks and Uncommon Profits* — quality, management, scuttlebutt research, pricing power.
- Peter Lynch, *One Up on Wall Street* — invest in what you can understand; observation is the beginning of research, not the end.
- Howard Marks, *The Most Important Thing* and Oaktree memos — risk as permanent loss (not volatility), second-level thinking, cycles.
- John C. Bogle, *The Little Book of Common Sense Investing* — costs, diversification, index humility.
- Burton Malkiel, *A Random Walk Down Wall Street* — efficient markets and the case for the default.

## Companion Project

This rule set is what disciplines [`kr-ai-trader`](https://github.com/cskwork/kr-ai-trader), an AI-driven Korean-equity investment workflow. The rules came first, the code came second — by design.

## Related

- [coding-agent-rules](https://github.com/cskwork/coding-agent-rules) — Ten Commandments for Coding Agents
- [planning-doc-rules](https://github.com/cskwork/planning-doc-rules) — Ten Rules for Writing a Planning Document

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
