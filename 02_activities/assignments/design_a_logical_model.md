# Assignment 1: Design a Logical Model

## Question 1
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).

Participant Name: Ryan Yeh

![sql assignment 1 question 1](https://github.com/user-attachments/assets/7512e0cd-156b-49c8-aa3a-2f81347d059c)

## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.

![sql assignment 1 question 2](https://github.com/user-attachments/assets/7e233d73-cd74-4896-a2f9-ce18aa9114c0)

## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

_Hint, search type 1 vs type 2 slowly changing dimensions._

Bonus: Are there privacy implications to this, why or why not?
```
Type 1 overwrites existing value with new value and does not retain history
Type 2 add a new row/record for new value and keeps a history of all changes

There's privacy implication to type 2 as customer may not expect their previous address to be retained
```

![sql assignment 1 question 3](https://github.com/user-attachments/assets/53f2c0d4-b22f-4961-9b88-14e779c6f305)

## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
The biggest difference between the AdventureWOrks schema and my ERD is how extensive the schema is. For example all related tables are grouped and color-coded to help visualize another layer of relationships between the tables (e.g. Sales vs Purchasing etc). However given the request for the assignment and how simply my diagram is, that is not as applicable but this is definitely something that should be done in real work.

The second difference I notice is how data are sub-divided and store in sepearate tables. For example, in my diagram I have one address field for each customer which is in contrast to how an address is stored separately in a "Address" table wich fields such as "AddressLine1" and "AddressLine2" etc. Again this is something that's not applicable for the nature of this assignment but a good practice for real work.
```

# Criteria

[Assignment Rubric](./assignment_rubric.md)

# Submission Information

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

### Submission Parameters:
* Submission Due Date: `September 28, 2024`
* The branch name for your repo should be: `model-design`
* What to submit for this assignment:
    * This markdown (design_a_logical_model.md) should be populated.
    * Two Entity-Relationship Diagrams (preferably in a pdf, jpeg, png format).
* What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pull/<pr_id>`
    * Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:
- [ ] Create a branch called `model-design`.
- [ ] Ensure that the repository is public.
- [ ] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [ ] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack at `#cohort-4-help`. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.
