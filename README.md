# Ten Commandments for AI Investment Agents

**English** | [한국어](README.ko.md)

Landing page: **https://cskwork.github.io/investment-agent-rules/**

A short, plain-language rule set for any AI agent that helps a human research, choose, size, or hold long-term investments — distilled from the people who actually made money for decades:

**Graham, Buffett, Munger, Fisher, Lynch, Marks, Bogle, Malkiel.**

Ten rules. One overlay for the Korean market. One enforcement map. No fluff.

## One-sentence conclusion

> Great investing is **not losing money first**, then buying understandable, high-quality businesses below what they are worth, with enough margin for being wrong, and holding them long enough to compound. If none of that genuinely applies to you, just buy a low-cost broad index fund.

## Why this exists

AI agents that touch money fail in predictable ways. They:

- chase returns before they have proven they cannot permanently lose the money;
- mistake a rising price for rising value;
- stack peer multiples and recent news into a "thesis";
- mistake being *comfortable* with a company for *understanding* it;
- approve the spreadsheet without checking whether the CEO actually returns cash to shareholders;
- define risk as price volatility, and then size positions that force them to sell at the bottom;
- follow the consensus more confidently because it sounds recent;
- claim an edge they have not earned across a real market cycle;
- cannot bring themselves to say "you don't have an edge — buy the index."

The Ten Commandments below — plus the *Korean Equity Overlay* and the *Investment Agent Enforcement Map* — block all of these.

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

1. **Capital Preservation First.** Do not lose money. Not "down on paper" — *actually* lose it. A 50% drop needs a 100% gain to break even; a 90% drop needs 900%. The math is brutal. Capital preservation is the umbrella goal that every other rule serves. The kind of loss that matters is *permanent* — but volatility becomes permanent loss the moment a position is sized so the investor is forced to sell. — *Buffett (Rule No. 1), Marks*
2. **Buy Value, Not Price.** Start from "what can this business earn?" — not from what the chart is doing. Price tells you how big the discount is. It is not the argument. — *Graham, Marks*
3. **Demand a Margin of Safety.** Pay enough below what you think the business is worth that even if you turn out to be wrong by 20–30%, you still don't get hurt. The less certain you are, the bigger the gap has to be. — *Graham, Buffett*
4. **A Stock Is a Piece of a Business.** Before you buy a share, ask: "Would I buy the whole company at this price?" If no, do not buy one share either. — *Buffett (Owner's Manual)*
5. **Stay in Your Circle of Competence.** Only own a business you can explain in one paragraph — revenue, customers, competition, and permanent-loss scenarios. If you cannot, pass; passing is a decision, not a failure. — *Buffett, Lynch*
6. **Quality at a Fair Price Beats Mediocrity at a Discount.** A great business at a reasonable price almost always beats a mediocre business at a bargain price. Look for hard-to-copy advantage, ability to raise prices, room to grow. Cheap is the floor; quality is the multiplier. — *Fisher, Buffett, Munger*
7. **Verify Management and Capital Allocation.** The CEO decides what happens to the cash. Check: skin in the game, buyback prices, acquisition track record, dilution, debt discipline, honest shareholder communication. A great business can still be wrecked by bad capital allocators. — *Buffett*
8. **Compound Long-Term; Don't Get in the Way.** Sell only when the original reason was wrong, the business itself got worse, or you have a clearly better idea. Time alone is never a sell signal. Every round-trip costs taxes, fees, and the price of not being there for the next leg up. — *Munger, Buffett*
9. **Use Cycles and Crowd Psychology Against Themselves.** When everyone is excited, the optimism is already in the price — so excitement is not new information. When everyone is panicked, prices are usually too low. Be smaller when the crowd is greedy. Look hardest at quality businesses when the crowd is fearful. — *Marks, Soros, Buffett*
10. **Without a Real Edge, Default to Low-Cost Diversification.** A real edge — informational, analytical, or behavioral — must be *earned*, not assumed. If none of those honestly describes you, buy a low-cost broad index fund, hold it for a long time, and stop fighting. The math favors that for the median investor. — *Bogle, Malkiel*

Full text and per-rule checklists with code gates live under [`rules/common/`](rules/common/00-index.md). Each rule starts with a one-line summary in plain English, then explains *why*, then a checklist, then the gate that turns the principle into deterministic code.

## The five that matter most

If only five rules survive, these are the ones that hold up the rest:

- **Rule 1** — do not lose money (the umbrella goal).
- **Rule 2** — buy value, not price.
- **Rule 3** — margin of safety.
- **Rule 4** — a stock is a piece of a business.
- **Rule 10** — if you don't have an edge, buy the index.

The other five — circle of competence, quality, management, compounding, cycles — are the operating system that turns those five into action.

## 10 questions before any position

Ask all ten. If you cannot answer one of them clearly, you are not ready to buy.

1. What is the **written "how could this permanently lose money"** scenario for this position, and can I survive it?
2. Can I explain in one paragraph how this business actually makes money?
3. Is the price meaningfully below my estimate of what the business is worth?
4. If my estimate is 20–30% too high, am I still protected?
5. Am I willing to hold this for five years or more?
6. Is there a durable advantage that competitors cannot easily copy?
7. Does management think and use cash like a long-term owner?
8. Is my real reason to buy *analysis*, or am I just joining the crowd?
9. Is the position sized so I can hold through a 30–50% drop without selling?
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

- **Plain language first.** Every rule opens with a one-line "in short" summary anyone can read. The deeper text is for the agent and the auditor.
- **Imperative, not advisory.** Each rule is a directive and a gate, not a value statement.
- **Pseudocode where it matters.** Principles are easy to nod at and hard to enforce. Each commandment ends with the gate that enforces it.
- **Capital preservation is the umbrella, not just another rule.** Rule 1 names the goal; the other nine are the techniques that defend it. Margin of safety, position sizing, diversification, cycle awareness all exist because permanent loss is the only thing the agent absolutely cannot recover from.
- **Permanent loss, not volatility.** Marks's refinement is built into Rule 1: drops in price with intact earnings are not risk events; they only become risk if the position is sized to force selling.
- **Investing first, trading second.** Earlier versions emphasized per-trade discipline (stop distances, position sizing from stop, kill switches). This version emphasizes ownership-grade investing — value, business quality, management, compounding — with trading discipline as a supporting layer.
- **Edge honesty is a first-class rule.** Most investors do not have a durable edge. Rule 10 turns that uncomfortable truth into a default behavior, not a disclaimer.
- **Market-agnostic core + market-specific overlay.** The ten rules apply anywhere; the KR overlay encodes what is different about Korean cash equities (taxes, settlement, auctions, VI, KSD).
- **LLM proposes, code disposes.** The enforcement map assumes an LLM is in the loop and unsafe by default. The gates are the safety.

## References

The rules are distilled from repeated patterns across these books and letters:

- Benjamin Graham, *The Intelligent Investor* — margin of safety, investor vs speculator, Mr. Market.
- Warren Buffett, Berkshire Hathaway *Owner's Manual* and the annual shareholder letters — Rule No. 1, stocks as pieces of businesses, intrinsic value, management as a capital allocator.
- Charlie Munger, *Poor Charlie's Almanack* — mental models across disciplines, inversion, "never interrupt compounding."
- Philip Fisher, *Common Stocks and Uncommon Profits* — business quality, management, scuttlebutt research, pricing power.
- Peter Lynch, *One Up on Wall Street* — invest in what you can understand; observation is the *beginning* of research, not the end.
- Howard Marks, *The Most Important Thing* and Oaktree memos — risk as permanent loss (not volatility), second-level thinking, cycles.
- John C. Bogle, *The Little Book of Common Sense Investing* — costs, diversification, index humility.
- Burton Malkiel, *A Random Walk Down Wall Street* — efficient markets and the case for the simple default.

## Companion Project

This rule set is what disciplines [`kr-ai-trader`](https://github.com/cskwork/kr-ai-trader), an AI-driven Korean-equity investment workflow. The rules came first, the code came second — by design.

## Related

- [coding-agent-rules](https://github.com/cskwork/coding-agent-rules) — Ten Commandments for Coding Agents
- [planning-doc-rules](https://github.com/cskwork/planning-doc-rules) — Ten Rules for Writing a Planning Document

## Customizing

Fork. Edit `rules/common/` last; edit the overlays and the enforcement map first.

A new rule must:
- Be one sentence at the top, with a checklist and a code gate below.
- Map to a real failure mode someone has actually paid for.
- Not duplicate an existing rule.

If your fork grows past fifteen commandments, you have a textbook, not a rule set.

## Disclaimer

This is an educational reference, not investment advice. Markets can and will find ways to lose money that this document does not anticipate. The author is not your fiduciary.

## License

MIT. See [LICENSE](LICENSE).
