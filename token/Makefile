.PHONY: token.wasm

src = $(wildcard *.cpp)
obj = $(src:.cpp=.wasm)
OPTS = -D'__COMMUNITY_ACCOUNT__=test1.cm'

token.wasm: $(src)
	eosio-cpp $(OPTS) -o $@ $^ -abigen -R ./ricardian

clean:
	rm $(obj)
