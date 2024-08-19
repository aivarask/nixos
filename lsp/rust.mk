# https://doc.rust-lang.org/rust-by-example/index.html
# ../Cargo.toml
# https://doc.rust-lang.org/cargo/reference/manifest.html

rust.test:
	cargo nextest run
rust.run:
	cargo run
rust.doc:
	cargo doc
rust.clean:
	rm -rf target Cargo.lock
rust.all: rust.test rust.run rust.doc

