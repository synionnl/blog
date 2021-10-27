# Answer questions product

## Interface

Wens: openapi en asyncapi samenvoegen to 1 api.

* [API](living-documentation/openapi.yaml)
* [Async API](living-documentation/asyncapi.yaml)

## Process

[Process](living-documentation/process.bpmn)

## Use cases

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

```plantuml

class AnswerQuestion implements AggregateRoot
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



```

### Answer question task

* [API](living-documentation/answer-question-user-task.openapi.yaml)
* [UI](living-documentation/answer-question.user-task.yaml)

### Review answer task

* [API](living-documentation/review-answer-user-task.openapi.yaml)
* [UI](living-documentation/review-answer.user-task.yaml)
* [BDD](living-documentation/review-answer-user-task.bdd.feature)

### Modify answer task

* [API](living-documentation/modify-answer-user-task.openapi.yaml)
* [UI](living-documentation/modify-answer.user-task.yaml)

### Send answer task

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

### Send question answered event task

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

* [API](living-documentation/asyncapi.yaml)

## Business requirements

[BDD](living-documentation/bdd.feature)