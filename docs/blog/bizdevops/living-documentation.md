# Answer questions product

The answer question product is used bij customers to ask questions by email or by using question forms on the website. 
A question is answered be an employee. 
Every answer is reviewed by a supervisor which either accepts or rejects an answer. 
A rejected answer is modified by the same person who has created the answer. 
The modified answer can be reviewed by any supervisor.
An accepted answer is send to the client by email.


## Interface

Wens: openapi en asyncapi samenvoegen to 1 api.

* [API](living-documentation/openapi.yaml)
* [Async API](living-documentation/publish-asyncapi.yaml)

## Process

[Process](living-documentation/process.bpmn)

## Use cases

### Answer question

* [UI](living-documentation/answer-question.user-task.yaml)
* [API](living-documentation/answer-question-user-task.openapi.yaml)

### Review answer

* [UI](living-documentation/review-answer.user-task.yaml)
* [Requirements](living-documentation/review-answer-user-task.bdd.feature)
* [API](living-documentation/review-answer-user-task.openapi.yaml)

### Modify answer

* [UI](living-documentation/modify-answer.user-task.yaml)
* [API](living-documentation/modify-answer-user-task.openapi.yaml)

### Send answer

An answer is sent by email to same email address from where the question was recieved.

### Send question answered event

* [API](living-documentation/subscribe-asyncapi.yaml)

### Revoke question

Any question for which the answer has not been sent can be revoked.

## Domain model

```plantuml

interface AggregateRoot
{
    DomainEvent[] Commit()
}

class AnswerQuestion
{
    {static} AnswerQuestion Create(Question question)
    void AnswerQuestion(Answer answer);
    void RejectAnswer(Rejection rejection);
    void AcceptAnswer(Acception acception);
    void ModifyAnswer(Modification modification);
    void SendAnswer(Answer answer);
    void SendQuestionAnsweredEvent(Event event);
    void RevokeQuestion(Revocation revocation);
}

class QuestionRecieved implements DomainEvent
class QuestionAnswered implements DomainEvent
class AnswerRejected implements DomainEvent
class AnswerAccepted implements DomainEvent
class AnswerModified implements DomainEvent
class AnswerSent implements DomainEvent
class QuestionAnsweredEventSent implements DomainEvent
class QuestionRevoked implements DomainEvent

AnswerQuestion .d.|> AggregateRoot
AggregateRoot *-d- DomainEvent

```

## Business requirements

[Requirements](living-documentation/bdd.feature)