from llama_index.llms.ollama import Ollama
# llm = Ollama(model="llama3.1:latest", request_timeout=120.0)
llm = Ollama(model="deepseek-r1:latest", request_timeout=120.0)
resp = llm.complete("Make a simple website plan.")
print(resp)
