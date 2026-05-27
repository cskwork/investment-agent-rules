# 10. Without a Real Edge, Default to Low-Cost Diversification

> "Don't look for the needle in the haystack. Just buy the haystack."
> — John C. Bogle, *The Little Book of Common Sense Investing*

> "A blindfolded monkey throwing darts at a newspaper's financial pages could select a portfolio that would do just as well as one carefully selected by experts."
> — Burton Malkiel, *A Random Walk Down Wall Street*

## In short

Beating the market requires a *real* advantage. If you don't have one — and most people don't — the honest answer is to buy a low-cost broad index fund, hold it for a long time, and stop fighting.

## Why

The other nine rules describe what disciplined active investment looks like. This one names the uncomfortable truth that should sit under them: most investors — including most professional investors, and most LLM-driven agents — *do not have a durable edge*.

An edge is not a strong opinion. It is a structural reason your returns should be different from the market's. It comes in three flavors:

- **Information edge** — you have access to facts the market does not. Increasingly rare and increasingly regulated.
- **Analytical edge** — you process available information better, more patiently, or with a longer time horizon than competing capital does.
- **Behavioral edge** — you can be patient, hold through pain, and buy when others sell, because of your structure or your temperament. The most durable edge available to most investors, and the easiest one to claim falsely.

If none of those three honestly describe the agent, the disciplined choice is not to play the stock-picking game harder. It is to step out of the game.

The default for the honest agent without an edge is well-established and remarkably hard to beat: broad, low-cost, globally diversified ownership of productive assets, held for a long time, rebalanced on a fixed schedule, with minimum costs. Bogle's argument — validated across decades of fund-vs-index data — is that the gross-minus-cost arithmetic favors the index for the median investor. The math is on the side of doing less.

This rule does not make the other nine wrong. It makes them *conditional*. If the agent has an edge, the other nine are the manual for using it well. If the agent does not, this one is the manual for not paying for the illusion of one.

## Checklist

- [ ] The agent has written, explicit answers to: *where is my information edge, my analytical edge, my behavioral edge?*
- [ ] Edge claims are evidence-based (track record across cycles), not narrative-based.
- [ ] When no genuine edge exists, the default portfolio is broad, low-cost, diversified, and rebalanced on a fixed schedule — not stock-picked.
- [ ] Costs (expense ratios, taxes, spread) are explicit and minimized.
- [ ] "I want to pick stocks because it's interesting" is rejected as a reason — entertainment is not an edge.
- [ ] The agent is willing to recommend "do nothing different from the index" as a legitimate output.

## How an AI investment agent enforces this

```python
def has_genuine_edge(agent):
    return (
        agent.documented_information_edge
        or agent.documented_analytical_edge_with_oos_record
        or agent.documented_behavioral_edge_with_track_record
    )

def default_strategy_for(agent, goal):
    if not has_genuine_edge(agent):
        return IndexDefault(
            allocation=goal.risk_appropriate_allocation,
            instruments=goal.broad_low_cost_index_funds,
            rebalance="fixed_schedule",
            cost_cap_bps=20,
        )
    return ActivePortfolio(rules=ten_commandments)
```

The strongest investment edge available to most agents is the willingness to admit they do not have one. The cheapest path to long-term wealth, for the median investor, is to stop fighting that and buy the market.
