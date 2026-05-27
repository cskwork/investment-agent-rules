# 2. Buy Value, Not Price

> "In the short run, the market is a voting machine; but in the long run, it is a weighing machine."
> — Benjamin Graham

> "The relationship between price and value is the ultimate determinant of investment success."
> — Howard Marks, *The Most Important Thing*

## In short

The right first question is "what can this business earn?" — not "what is the price doing today?" Price tells you how big the discount is. Value tells you whether there is anything to buy in the first place.

## Why

Price is what someone is willing to pay this morning. Value is what the cash flows are worth across years and across cycles. They drift apart constantly. Long-term gains come from buying when value is higher than price. Long-term losses come from buying when price is higher than value, no matter how convincing the chart.

If the agent ranks ideas by *price action* — momentum, "the market knows something", relative strength alone — it is a price agent, not an investment agent. Price is an input to the decision (it tells you how much of a discount you are getting). It is not the decision itself.

A common failure mode: a stock has been rising, and that rise is then used as evidence that it should keep rising. The chart starts to feel like an argument. It is not. Past price action is part of *price*; it has nothing to do with what the business can earn.

## Checklist

- [ ] Every proposed position has a written value thesis: what the business earns, how stably, at what return on its capital, for how long.
- [ ] The value thesis is grounded in cash flow or owner earnings — not just "the stock trades at a lower P/E than peers".
- [ ] Price is used only to decide *how big the discount is*, never to decide *whether* the business is worth owning.
- [ ] "It went up, so it must be right" is explicitly rejected as evidence.
- [ ] When the agent cannot describe the value without referring to price, the position is blocked.

## How an AI investment agent enforces this

```python
def passes_value_thesis(proposal):
    if not proposal.has_intrinsic_value_estimate():
        return Reject("no_independent_value_thesis")
    if proposal.value_thesis_source == "price_action_only":
        return Reject("price_disguised_as_value")
    if proposal.value_estimate_horizon_years < 3:
        return Reject("thesis_too_short_term_for_compounding")
    return Allow()
```

Value comes first. Price tells you how big the discount is.
