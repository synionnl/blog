# Zeebe and .Net, a love story…

Service orchestration is an important part of the micro service puzzle. With Zeebe and the [zb-client-bootstrap extension for .Net](https://github.com/camunda-community-hub/zeebe-client-csharp-bootstrap) your life as a .Net micro service developer just got a lot easier.

![Zeebe and .Net](teaser.png?aling=center)

## Choreography v.s. Orchestration

When working with micro services you typically have two integration options: service choreography and service orchestration.

With service choreography services publish and subscribe to events. In theory the publisher is highly decoupled from its subscribers because they do not care if, when and who consumes the events, which is great. In practice things can be less ideal. Often event consumption is not optional, Furthermore there can be also an (hidden) order in which events need to be consumed often within a certain time frame.

With service orchestration an orchestrator sends commands to services: the orchestrator tells the service when and what to do. These commands can be visualized in a process. In BPM these commands are called tasks. Tasks can be synchronous or asynchronous.

## Processes, Camunda, Zeebe?

Zeebe (by Camunda) is an opensource process engine which runs ISO standard BPMN 2.0 processes. Zeebe scales horizontally, is language agnostic, fault tolerant and is highly available. It has built-in state management, retry policy support and audit logging which makes your life as a developer a lot easier, especially when you are working with micro services.

Zeebe is a service orchestrator but it uses events internally. A job is published in queue whenever a task in a process instance is activated. Services can subscribe to jobs of a certain type. Multiple service instances can subscribe to the same type (competing consumers) and because the services are decoupled from Zeebe, services can be created in any language.

Zeebe is [opensourced](https://github.com/camunda-cloud/zeebe) and available as a [hosted service](https://camunda.com/products/cloud/) or as a [docker container](https://hub.docker.com/r/camunda/zeebe/) which you can host yourself.

---

## .Net job handling

So for the developer it all boils down to handling jobs: input > output. With the [zb-client-bootstrap nuget package](https://www.nuget.org/packages/zb-client-bootstrap/) this is easy. This package uses the [zb-client](https://www.nuget.org/packages/zb-client) internally and ads logic so that job handlers are automatically discovered, hosted and wired to Zeebe.

Now, show me the money!

### To start, add the nuget package to your project:

`dotnet add package zb-client-bootstrap`

### Then bootstrap Zeebe:

```csharp
class DoSomethingHandler : IAsyncJobHandler<DoSomething>
{
    public async Task HandleJob(DoSomething job, CancellationToken cancellationToken)
    {
        await Usecase.ExecuteAsync();
    }
}

class DoSomething : AbstractJob
{
    public DoSomething(IJob job) : base(job)
    { }
}
```

Let me explain what is happening here. `BootstrapZeebe()` will scan every assembly starting with ‘SimpleAsyncExample’ for job handlers. Every handler will automatically be added to the service collection, hosted in a `IHostedService` instance and wired to Zeebe.

A job handler is a class which implements the `IAsyncJobHandler<TJob>` interface. This interface is generic and expects a job type which extends `AbstractJob`.

```csharp
public interface IAsyncJobHandler<TJob>  where TJob : AbstractJob
{
    Task HandleJob(TJob job, CancellationToken cancellationToken);
}
```

### Create a process:

[simple process](simple-process.bpmn)

### And lastly, add your job and job handler:

```csharp
class DoSomethingHandler : IAsyncJobHandler<DoSomething>
{
    public async Task HandleJob(DoSomething job, CancellationToken cancellationToken)
    {
        await Usecase.ExecuteAsync();
    }
}

class DoSomething : AbstractJob
{
    public DoSomething(IJob job) : base(job)
    { }
}
```

This is it. The task of type ‘DoSomething’ in any process instance is now handled by the `DoSomethingHandler`. The Zeebe job is automatically completed when the job is handled resulting in activating the next step in the process. Unhandled exceptions are also automatically sent to Zeebe resulting in the activation of the retry policy.

---

### Response values

But there is more. Processes can make decisions based on data. Data can be added as variables to the process instance. Typically this information is added when completing a job. Therefore it is also possible to complete a job with a response. This is done by adding a second type to the `IAsyncJobHandler<TJob, TResponse>`. The response is automatically serialized and passed to Zeebe when completing the job.

[simple process with variable](simple-process-with-variable.bpmn)

```csharp
class DoSomethingHandler : IAsyncJobHandler<DoSomething, Response>
{
    public async Task<Response> HandleJob(DoSomething job, CancellationToken cancellationToken)
    {
        await Usecase.ExecuteAsync();
        return  new Response() 
        {
            Property = job.Key % 2 == 0
        };
    }
}

class DoSomething : AbstractJob
{
    public DoSomething(IJob job) : base(job)
    { }
}

class Response 
{
    public bool Property { get; set; }
}
```

Property of type boolean is automatically added to the process instance making it possible to add the following condition to the decision flow `=Property=true`

---

### Business exceptions

Exceptions are not only technical; they also live in the business domain. Therefore it is possible to throw business exceptions inside the job handler resulting in an error automatically being send to Zeebe. A business exception is any exception which extends JobException. Business exceptions can be handled in the process by modelling an catch event on the task boundry.

[simple process with exception](simple-process-with-exception.bpmn)

```csharp
class DoSomethingHandler : IAsyncJobHandler<DoSomething, Response>
{
    public async Task<Response> HandleJob(DoSomething job, CancellationToken cancellationToken)
    {
        await Usecase.ExecuteAsync();
        return  new Response() 
        {
            Property = job.Key % 2 == 0
        };
    }
}

class DoSomething : AbstractJob
{
    public DoSomething(IJob job) : base(job)
    { }
}

class Response 
{
    public bool Property { get; set; }
}
```

---

## Closing notes

I want to thank the people at Camunda for their excellent products. I am a big BizDevOps fan. Processes are an important part of the BizDevOps puzzle and Camunda nailed it.

* Want to know more about process automation? Download @Bernd Rücker excellent e-book [“Practical Process Automation”](https://page.camunda.com/wp-practical-process-automation-book-digital-release);
* Checkout my opensource .Net extension at [GitHub](https://github.com/arjangeertsema/zeebe-client-csharp-bootstrap);
* There is also a [synchronous job handler](https://github.com/arjangeertsema/zeebe-client-csharp-bootstrap/blob/main/src/Zeebe.Client.Bootstrap/Abstractions/IJobHandler.cs) available;
* You can configure job handling by adding [attributes](https://github.com/arjangeertsema/zeebe-client-csharp-bootstrap/tree/main/src/Zeebe.Client.Bootstrap/Attributes) to the job;
* The service lifetime is configurable by adding the [ServiceLifeTimeAttribute](https://github.com/arjangeertsema/zeebe-client-csharp-bootstrap/blob/main/src/Zeebe.Client.Bootstrap/Attributes/ServiceLifetimeAttribute.cs) to the job handler;

Go play around with Zeebe, BPM and, if you are into .Net, the zb-client-bootstrap nuget package.

Have fun!