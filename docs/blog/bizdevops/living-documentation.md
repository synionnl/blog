# Answer questions product

## Product

The answer question product is used bij customers to ask questions by email or by using question forms on the website. 
A question is answered be an employee. 
Every answer is reviewed by a supervisor who either accepts or rejects an answer. 
A rejected answer is modified by the same person who has created the answer. 
The modified answer can be reviewed by any supervisor.
An accepted answer is send to the client by email.

* [UI](living-documentation/product.user-task.yaml)
* [Acceptance criteria](living-documentation/product.feature)
* [API](living-documentation/product.openapi.yaml)

## Process

* [Process](living-documentation/process.bpmn)
* [Acceptance criteria](living-documentation/process.feature)

## Use cases

### Bot answer question

The bot will always answer every question together with a probabilty percentage (0-100%). This percentage describes the chance that the answer is correctly answered: 

* 0%: the answer is not correct;
* 100%: the answer is correct;

### Answer question

* [UI](living-documentation/answer-question.user-task.yaml)
* [API](living-documentation/answer-question.openapi.yaml)

### Review answer

* [UI](living-documentation/review-answer.user-task.yaml)
* [Acceptance criteria](living-documentation/review-answer.feature)
* [API](living-documentation/review-answer.openapi.yaml)

### Modify answer

* [UI](living-documentation/modify-answer.user-task.yaml)
* [API](living-documentation/modify-answer.openapi.yaml)

### Send answer

An answer is sent by email to same email address from where the question was recieved.

### Revoke question

Any question for which the answer has not been sent can be revoked.

## Class diagram

```plantuml

interface AggregateRoot
{
    DomainEvent[] Commit()
}

class AnswerQuestion
{
    {static} AnswerQuestion Create(Question question)
    
    void AnswerQuestion(BotAnswer answer);
    void AnswerQuestion(Answer answer);
    void RejectAnswer(Rejection rejection);
    void AcceptAnswer(Acception acception);
    void ModifyAnswer(Modification modification);
    void SendAnswer(Answer answer);
    void RevokeQuestion(Revocation revocation);
}

class QuestionRecieved implements DomainEvent
class QuestionAnsweredByBot implements DomainEvent
class QuestionAnswered implements DomainEvent
class AnswerRejected implements DomainEvent
class AnswerAccepted implements DomainEvent
class AnswerModified implements DomainEvent
class AnswerSent implements DomainEvent
class QuestionRevoked implements DomainEvent

AnswerQuestion .d.|> AggregateRoot
AggregateRoot *-d- DomainEvent

```