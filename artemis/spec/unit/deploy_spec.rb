require 'artemis/commands/deploy'

RSpec.describe Artemis::Commands::Deploy do
  it "executes `deploy` command successfully" do
    output = StringIO.new
    options = {}
    command = Artemis::Commands::Deploy.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
