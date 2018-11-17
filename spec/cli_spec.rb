# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'CLI', type: :aruba do
  context 'as a thor-based CLI' do
    let(:no_args_output) do
      <<~OUTPUT
        Commands:
          deadlock [FILE]          # Parses input [FILE], then prints deadlock information
          deadlock help [COMMAND]  # Describe available commands or one specific command
      OUTPUT
    end

    context 'when called with no args' do
      before(:each) { run 'bin/deadlock' }

      it 'shows help' do
        expect(last_command_started).to have_output no_args_output
      end
    end

    context 'when called with `help`' do
      before(:each) { run 'bin/deadlock help' }

      it 'shows help' do
        expect(last_command_started).to have_output no_args_output
      end
    end
  end

  context 'running input' do
    context 'when input has a safe path' do
      before(:each) do
        copy '%/sys_config.txt', 'sys_config.txt'
        run 'bin/deadlock sys_config.txt'
      end

      it 'outputs `SAFE`' do
        expect(last_command_started).to have_output 'SAFE'
      end
    end
  end
end
