# 6. Quality at a Fair Price Beats Mediocrity at a Discount

> "It's far better to buy a wonderful company at a fair price than a fair company at a wonderful price."
> — Warren Buffett

> "The investor of today does not profit from yesterday's growth."
> — Philip Fisher, *Common Stocks and Uncommon Profits*

## In short

A great business at a reasonable price almost always beats a mediocre business at a cheap one. Cheap is just the floor. Quality is what multiplies over time.

## Why

Graham's early framework was about finding *statistical bargains*: companies trading below the value of their assets, cigar-butts with one last puff in them. Buffett's evolution — under Munger's influence, and through Fisher's lens — was the realization that the engine of long-term compounding is **business quality**, not the size of the initial discount.

A mediocre business bought at half price still gets ground down by bad capital allocation, declining returns on capital, and the slow erosion of competitive position. A great business bought at a fair price keeps compounding: it can raise prices to offset inflation, scale extends its moat, and the cash it retains gets reinvested at high returns to produce another wave of earnings.

Quality is concrete and checkable — not a vibe:

- **Pricing power.** Can it raise prices without losing customers?
- **Durable advantage** (moat). Brand. Scale. Switching costs. Network effects. Regulatory position. Low-cost producer.
- **High and stable return on invested capital (ROIC)**, across at least one full cycle — meaning the business earns more on the cash it deploys than that cash costs.
- **Predictable, repeatable demand.**
- **Room to reinvest** at high returns — a long runway, not a saturated market.
- **Capital allocation discipline.** This is its own rule (see Rule 7).

Cheap is not the goal. Compounding is the goal. Cheap is the floor; quality is the multiplier.

## Checklist

- [ ] Every position has an explicit quality assessment, not just a table of multiples.
- [ ] The agent has identified the *specific* moat (one or more of: brand, scale, switching costs, network, regulatory, low-cost producer).
- [ ] ROIC is checked across at least one full cycle, not a single good year.
- [ ] Revenue growth is broken into volume, price, and acquisition — and judged for each.
- [ ] "Cheap and broken" candidates require a separate, harder thesis: what changes the business?

## How an AI investment agent enforces this

```python
def passes_quality_test(proposal):
    q = proposal.quality_assessment
    if not q.identified_moat:
        return Reject("no_durable_advantage")
    if q.roic_5yr_median < 0.10:
        return Reject("roic_below_compounding_threshold")
    if q.revenue_growth_attribution is None:
        return Reject("growth_not_decomposed")
    if proposal.is_deep_value and not proposal.has_change_catalyst:
        return Reject("cheap_without_a_thesis_for_change")
    return Allow()
```

A great business at a fair price is rarer than it sounds — but the patience to wait for one is the trait that separates compounding from churning.
