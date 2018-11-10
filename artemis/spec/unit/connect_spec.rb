require 'artemis/commands/connect'

RSpec.describe Artemis::Commands::Connect do
  it "executes `connect` command successfully" do
    output = StringIO.new
    options = {}
    command = Artemis::Commands::Connect.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
