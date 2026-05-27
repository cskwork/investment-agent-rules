# 6. Quality at a Fair Price Beats Mediocrity at a Discount

> "It's far better to buy a wonderful company at a fair price than a fair company at a wonderful price."
> — Warren Buffett

> "The investor of today does not profit from yesterday's growth."
> — Philip Fisher, *Common Stocks and Uncommon Profits*

## Why

Graham's early framework was about buying statistical bargains: net-net, cigar-butt, asset-based discounts. Buffett's evolution — under Munger's influence and through Fisher's lens — was the recognition that the engine of long-term compounding is *business quality*, not the size of the initial discount.

A mediocre business at half price still gets buried under bad capital allocation, declining returns on capital, and the slow erosion of competitive position. A great business at a fair price compounds: pricing power offsets inflation, scale extends the moat, retained earnings reinvested at high returns produce another wave of earnings.

Quality is concrete and verifiable, not aesthetic:

- Pricing power — can it raise prices without losing customers?
- Durable competitive advantage — brand, scale, switching costs, network effects, regulatory position, low-cost producer status.
- High and stable return on invested capital across the cycle.
- Predictable, repeatable customer demand.
- Long runway to reinvest at high returns.
- Management track record of capital discipline (this is its own rule — see Rule 6).

Cheap is not the goal. Compounding is the goal. Cheap is the floor; quality is the multiplier.

## Checklist

- [ ] Every position has an explicit quality assessment, not just a multiples table.
- [ ] The agent has identified the specific moat (one or more of: brand, scale, switching costs, network, regulatory, low-cost producer).
- [ ] ROIC is tracked across at least one full cycle, not a single year.
- [ ] Revenue growth is decomposed into volume, price, and acquisition — and judged accordingly.
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

A wonderful business at a fair price is rarer than it sounds — but the patience to wait for one is the trait that separates compounding from churning.
