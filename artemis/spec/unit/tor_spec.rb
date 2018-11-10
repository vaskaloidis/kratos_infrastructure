require 'artemis/commands/tor'

RSpec.describe Artemis::Commands::Tor do
  it "executes `tor` command successfully" do
    output = StringIO.new
    options = {}
    command = Artemis::Commands::Tor.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
