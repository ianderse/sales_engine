guard :minitest do
  watch(%r{^test/(.*)_test\.rb$}) do |fragments|
    "test/#{fragments[1]}_test.rb"
  end
  watch(%r{^lib/(.*)\.rb$}) do |fragments|
    "test/#{fragments[1]}_test.rb"
  end
end
