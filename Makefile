start: CTL_SECRET
	./scripts/setup.sh
	tmuxinator start

stop:
	tmuxinator stop terrarium

clean:
	./scripts/cleanup.sh
	rm -f CTL_SECRET

CTL_SECRET:
	hab sup secret generate > CTL_SECRET
