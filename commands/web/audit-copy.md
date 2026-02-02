# Does a copywriter audit on a given website

# Variables

website=$1

# Workflow

1. Check if user provided <website>. If not, ask for it.
2. Ask the user for the target audience, their pain points, their needs.
3. Check the copy of the provided website. With a new subagent, pull ideas and insights from the top 10 advertising practitioners in history. In a new subagent then rewrite the whole copy of <website> so that it's written for the target audience, adressing their pain points and providing solutions for them. 
4. Print out the rewrite of the copy and then score it with a different subagent on a scale of 0-100. Score different categories of the copy (how convincing it is, how specific, etc) and give an overall score too, based on the subcategory scores.
5. Ask the user if he wants to continue refining the copy. 
6. If he wants to refine it, ask specific questions to address the missing areas. Then refine the copy to make it better. Go to step 3. but with the latest copy and go through the workflow over again.

# Some key points to cover

- The best proof is the specific pain. If we can articulate the client's pain to them better than they can articulate it themselves, we won. This exists in the specific, not in the vague. Instead of saying "It sucks to be overweight", saying "Tired of feeling the shame in the beach, and deciding to leave your clothes on?", or "Fed up with unable to button your favorite pants?"
