require 'artemis/commands/authenticate'

RSpec.describe Artemis::Commands::Authenticate do
  it "executes `authenticate` command successfully" do
    output = StringIO.new
    options = {}
    command = Artemis::Commands::Authenticate.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
