# MCP vs OpenAPI: What Am I Missing?

*June 15, 2025*

Can anyone explain why MCP is better than just using an OpenAPI schema?

I've been banging my head against this question for a while now. I've run several deep research agents on it. I've read the docs. I've read the think pieces. And I keep getting the same answer dressed up in different buzzwords: "MCP is the USB-C of AI." If I wasn't already bald, I'd be ripping my hair out.

Here's the thing. There are *tons* of preexisting APIs out in the wild. Mature, battle-tested, well-documented APIs with OpenAPI schemas that already describe exactly what they do, what parameters they accept, and what they return. That's... tool invocation. That's literally the thing MCP claims to solve. So what exactly is the new hotness adding?

At [Chipp](https://chipp.ai), I've already built something that makes it easy to add existing suites of APIs as tools for AI agents to invoke. You point it at an API, it reads the schema, and the AI can call those endpoints as tools. We're also letting Chipp chats invoke *other* Chipp chats as tools, which handles the prompt template use case. None of this required a new protocol. It required reading a spec that already existed.

The MCP pitch, as far as I can tell, boils down to: "What if there was a standardized way for AI models to discover and call tools?" Great. OpenAPI is a standardized way to describe callable tools. It has versioning. It has auth schemes. It has request/response schemas. It has a massive ecosystem of tooling. It's been around since the Swagger days. What am I missing?

When I push on this with people, I usually get one of a few responses. The first is discovery -- MCP lets models "discover" available tools dynamically. Okay, but you can serve an OpenAPI spec from a well-known URL too. The second is that MCP is "model-native" -- designed specifically for how LLMs think about tool use. But in practice, you're still just describing a function signature with parameters and return types. Whether you call it a "tool" or an "endpoint," the LLM doesn't care. It's reading a description and deciding whether to call it.

The third response is the one that actually gives me pause: MCP supports bidirectional communication. The server can push context to the model, not just respond to requests. That's genuinely different from a REST API. Streaming state updates, real-time context injection, the model being able to subscribe to changes -- that's something OpenAPI wasn't designed for. But is that what most people are using MCP for? From what I can tell, the vast majority of MCP servers are just wrapping existing REST APIs with an MCP-shaped interface. It's an adapter pattern on top of something that already worked.

There's also the local tooling angle. MCP shines when you're connecting a model to your local filesystem, your IDE, your dev environment. Things that don't have HTTP APIs. If you're vibe coding your own vertical agent and want Claude to read your files and run your tests, MCP makes that easy. I get that. But that's a developer ergonomics play, not a protocol revolution.

What bugs me is the hype gap. The way people talk about MCP, you'd think it's a fundamental breakthrough in how AI interacts with the world. But when you actually look at what it does, it's... a JSON-RPC protocol for tool calling. That's fine. JSON-RPC is fine. But "fine" doesn't usually warrant the kind of breathless coverage this thing is getting.

I think part of what's going on is that MCP arrived at exactly the right moment. Everyone's building agents. Everyone needs tool calling. And here comes Anthropic with an open protocol that has the word "Model" right in the name. It *feels* like the right answer even if the existing answer was already sitting right there.

The ecosystem momentum is real, though. I'll give it that. When every major AI company and half the developer tools market starts supporting something, it doesn't matter if it's technically redundant -- it becomes the standard by sheer gravity. Standards win by adoption, not by technical superiority. VHS beat Betamax. USB-C beat... well, everything, eventually. Maybe MCP beats OpenAPI-for-tool-calling simply because everyone decided it would.

So here's my actual take: if you're building local dev tooling or IDE integrations, MCP is a clear win. If you're doing anything with bidirectional, stateful communication between a model and a service, MCP adds real value. But if you're wrapping existing REST APIs so an AI can call them? You might be adding a layer of complexity on top of something OpenAPI already solved.

I posted this question on LinkedIn and it blew up -- 175 likes, 209 comments, and a healthy mix of people agreeing with me and people telling me I was missing the point. If you're in the latter camp, I'm genuinely asking: show me the receipts. Not the metaphors. Not the USB-C analogies. Show me the concrete use case where MCP does something that a well-structured OpenAPI spec plus an LLM with tool-calling support cannot.

I'm still waiting.

---

© 2026 Hunter Hodnett

- [GitHub](https://github.com/hunterchristian)
- [LinkedIn](https://linkedin.com/in/hunterhodnett)
