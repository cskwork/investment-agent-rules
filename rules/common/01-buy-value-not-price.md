# 1. Buy Value, Not Price

> "In the short run, the market is a voting machine; but in the long run, it is a weighing machine."
> — Benjamin Graham

> "The relationship between price and value is the ultimate determinant of investment success."
> — Howard Marks, *The Most Important Thing*

## Why

The first question is not "what is the price doing?" It is "what can this asset earn over its lifetime, and what is that stream of earnings worth today?"

Price is what someone is willing to pay this morning. Value is what the cash flows are worth across the cycle. They diverge constantly. Long-term returns come from buying when value exceeds price; long-term losses come from buying when price exceeds value, no matter how convincing the chart.

An agent that ranks ideas by price action — momentum, "the market knows something", relative strength alone — is a price agent, not an investment agent. Price is an input to the decision (it sets the discount), not the decision itself.

## Checklist

- [ ] Every proposed position has a written intrinsic-value thesis: what the business earns, how stably, at what return on capital, for how long.
- [ ] The thesis is grounded in cash flow or owner earnings, not multiples scraped from peers.
- [ ] Price is used to size the *discount*, not to validate the thesis.
- [ ] "It went up, therefore it must be right" is explicitly rejected as evidence.
- [ ] When the agent cannot articulate value independently of price, the position is blocked.

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

Value comes first. Price is the discount, not the argument.
