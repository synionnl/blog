# Answer questions product

## Interface

Wens: openapi en asyncapi samenvoegen to 1 api.

* [API](living-documentation/openapi.yaml)
* [Async API](living-documentation/publish-asyncapi.yaml)

## Process

[Process](living-documentation/process.bpmn)

## Use cases

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.



### Answer question

* [API](living-documentation/answer-question-user-task.openapi.yaml)
* [UI](living-documentation/answer-question.user-task.yaml)

### Review answer

* [API](living-documentation/review-answer-user-task.openapi.yaml)
* [UI](living-documentation/review-answer.user-task.yaml)
* [BDD](living-documentation/review-answer-user-task.bdd.feature)

### Modify answer

* [API](living-documentation/modify-answer-user-task.openapi.yaml)
* [UI](living-documentation/modify-answer.user-task.yaml)

### Send answer

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

### Send question answered event

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

* [API](living-documentation/subscribe-asyncapi.yaml)

### Revoke question

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

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
class QuestionRevoked implements DomainEvent

AnswerQuestion .d.|> AggregateRoot
AggregateRoot *-d- DomainEvent

```

## Business requirements

[BDD](living-documentation/bdd.feature)