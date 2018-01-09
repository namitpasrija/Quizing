class TestWorker
	@queue = :new_test

	def self.perform(testid)
		@test=Test.find_by_id(testid)
		puts('Test Finisted '+@test.title)
	end

end

