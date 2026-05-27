# 9. Use Cycles and Crowd Psychology Against Themselves

> "The most important thing is being attentive to cycles… we have no idea where we are going, but we ought to know where we are."
> — Howard Marks

> "Be fearful when others are greedy, and greedy when others are fearful."
> — Warren Buffett

## In short

Markets swing between greed and fear. When everyone is excited, the optimism is already in the price — so excitement is not new information. When everyone is panicked, prices are usually too low. Be smaller when the crowd is greedy. Look hardest at quality businesses when the crowd is fearful.

## Why

Markets are not steady-state systems. They oscillate between optimism and pessimism, greed and fear, expansion and contraction. The swing is driven by human behavior and amplified by feedback loops — what Soros called *reflexivity* — where rising prices justify rising estimates, which then justify rising prices.

Howard Marks's framing is **second-level thinking**. The first-level thinker says, "this company is great, I should buy it." The second-level thinker says, "*everyone knows* this company is great — what is the price I would pay where the market does not *already assume* it?" That is where edge lives.

Edge does not come from agreeing with the consensus more confidently. It comes from being right about something the consensus has missed, or about where the consensus has overshot. That kind of edge is rare. It must be earned, not assumed.

The practical consequence is asymmetric behavior across the cycle:

- In euphoria, the bar for adding risk goes *up*. The agent does not chase. New positions get smaller, not larger.
- In panic, the agent looks hardest at quality businesses that have been mispriced because everyone is selling indiscriminately.
- In the boring middle, the agent does the unfashionable work of waiting.

Crowd psychology is also the agent's own enemy. An agent that reads recent prices, recent news, and recent commentary will inherit the consensus mood by default. Counterweighting that inheritance is the agent's job.

## Checklist

- [ ] Every position has an explicit "what does the consensus believe, and where am I different?" statement.
- [ ] Position size is regime-adjusted: smaller in obvious euphoria, larger only when both quality *and* price line up.
- [ ] The agent does not use recent price strength or a popular narrative as evidence for the thesis.
- [ ] Macro forecasts (predictions about interest rates, GDP, the cycle) are not used as the basis for individual positions — they are inputs to *position sizing*, not to *picking*.
- [ ] When everyone is panicking, the agent's review list is the names it already understands and already wanted to own at a lower price.

## How an AI investment agent enforces this

```python
def passes_second_level_test(proposal):
    if not proposal.consensus_view_documented:
        return Reject("no_consensus_view")
    if not proposal.differentiated_view_documented:
        return Reject("no_differentiated_view")
    if proposal.thesis_relies_on_macro_forecast:
        return Reject("macro_forecast_as_stock_thesis")
    return Allow()

def regime_adjusted_size(base_size, regime):
    if regime == "euphoria":
        return base_size * 0.5
    if regime == "panic" and proposal.quality_test_passed:
        return base_size * 1.2
    return base_size
```

The cycle will turn. The crowd will be wrong at the extremes. The discipline is to act on those turns *while they are unpopular*, not after they are obvious.
