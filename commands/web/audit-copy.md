# Copywriter audit for a website

website=$1

## Inputs

1. If <website> is not provided, ask for it.
2. Ask the user for:
   - Target audience (who, demographics, identity)
   - Top 3 pain points (specific situations, not vague feelings)
   - What the product/service solves for them
   - Audience awareness level:
     - **Unaware**: Don't know they have a problem
     - **Problem Aware**: Know the problem, don't know solutions exist
     - **Solution Aware**: Know solutions exist, don't know your product
     - **Product Aware**: Know your product, haven't bought yet
     - **Most Aware**: Know your product well, just need the right offer

## Fetch & Analyze

3. Fetch and extract all copy from <website>.

## Rewrite

4. Rewrite the full copy applying these practitioner principles:

**Specificity & Proof**
- Articulate the reader's pain better than they can. Not "It sucks to be overweight" but "Tired of leaving your shirt on at the beach?" (Halbert, Hopkins, Ogilvy)
- Replace every vague claim with concrete facts, figures, outcomes. "Bakes in 11 minutes" beats "bakes quickly." (Ogilvy, Hopkins)
- Stack proof until skepticism is irrational: testimonials, numbers, case studies, demonstrations. (Bencivenga)

**Desire & Awareness**
- Match copy to the reader's awareness level — problem-aware needs different framing than solution-aware. (Schwartz)
- Enter the conversation already in the reader's mind. Open with what they're thinking, not what you want to say. (Collier)
- Channel existing desire onto the product. Never try to manufacture want. (Schwartz)
- Find the dominant emotion in the market (fear, frustration, aspiration) and build the pitch around it. (Bencivenga)

**Structure & Flow**
- Every sentence's job is to get the next sentence read. Short opener, then momentum. (Sugarman)
- Grab → Fascinate → Close. Bold opening, compelling specifics, urgent close. (Halbert)
- Plant seeds of curiosity between sections: "But that's not even the best part..." (Sugarman)
- Gradualize claims — each one accepted before the next is introduced. (Schwartz)

**Offer & CTA**
- Frame value as a multiple of price by stacking tangible components. (Hormozi)
- Name the offer something proprietary and specific, not generic. (Hormozi)
- Every section drives toward one clear, urgent call to action with a deadline. (Kennedy)
- Make the guarantee so bold it becomes a selling point. (Bencivenga)

**Voice & Audience**
- Write to one person. Use "you." Conversational, like a letter to a friend. (Halbert)
- Sell the emotional concept, not the product. A smoke detector sells family safety. (Sugarman)
- Speak the language of the reader's "herd" — their frustrations, words, aspirations. (Kennedy)
- Paint vivid mental pictures of the result using sensory language. (Collier)

## Scoring

5. Score the rewritten copy (0-100 each):
   - **Pain specificity**: Names exact situations, feelings, frustrations — not vague claims?
   - **Proof density**: Concrete facts, numbers, testimonials, demonstrations present?
   - **Awareness match**: Does the copy meet the reader where they are (problem-aware vs solution-aware)?
   - **Flow & readability**: Does every sentence pull the reader forward? No drop-off points?
   - **Offer clarity**: Is the value stack clear, the CTA obvious, the guarantee bold?
   - **Audience fit**: Does it sound like it was written *by* someone in the reader's world?
   - **Emotional resonance**: Does it tap the dominant emotion and channel existing desire?
   - **Overall**: Weighted average of the above.

## Refinement loop

6. Present the rewrite and scores. Ask if the user wants to refine.
7. If yes, ask targeted questions about the lowest-scoring categories, then rewrite. Repeat from step 4.
