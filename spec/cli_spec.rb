require 'spec_helper'

RSpec.describe 'CLI', type: :aruba do
  context 'as a thor-based CLI' do
    let(:no_args_output) do
      <<~OUTPUT
        Commands:
          deadlock exec [FILE]     # Parses input [FILE], then prints deadlock info
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

  describe 'running input' do
    let(:safe_output) do
      <<~OUTPUT
        SAFE
        Request Vector:
      OUTPUT
    end

    let(:unsafe_output) { safe_output.gsub 'SAFE', 'UNSAFE' }

    before(:each) do
      copy '%/unsafe.txt', 'unsafe.txt'
      copy '%/sys_config.txt', 'sys_config.txt'
      copy '%/wikipedia_example.txt', 'wikipedia_example.txt'
    end

    describe 'when deciding if a system is safe' do
      context 'if input has a safe path' do
        before(:each) do
          run 'bin/deadlock exec sys_config.txt', exit_timeout: 0.5
        end

        it 'outputs `SAFE`' do
          expect(last_command_started).to have_output \
            match_output_string 'SAFE.*'
        end
      end

      context 'if input does not have a safe path' do
        before(:each) do
          run 'bin/deadlock exec unsafe.txt', exit_timeout: 0.5
        end

        it 'outputs `UNSAFE`' do
          expect(last_command_started).to have_output \
            match_output_string 'UNSAFE.*'
        end
      end
    end

    describe 'when inputing a request vector' do
      context 'if input is valid' do
        before(:each) do
          run 'bin/deadlock exec sys_config.txt', interactive: true,
                                                  exit_timeout: 0.5
        end

        context 'if the request can be granted' do
          it 'outputs `GRANTED`' do
            type '1 0 2'
            expect(last_command_started).to have_output \
              include_output_string 'GRANTED'
          end
        end

        context 'if the request can not be granted' do
          it 'outputs `NOT GRANTED`' do
            type '9 9 9'
            expect(last_command_started).to have_output \
              include_output_string 'NOT GRANTED'
          end
        end
      end

      context 'if input is invalid' do
        before(:each) do
          run 'bin/deadlock exec wikipedia_example.txt', interactive: true,
                                                         exit_timeout: 0.5
          type 'garbage'
        end

        it 'outputs `Wrong input!`' do
          expect(last_command_started).to have_output \
            include_output_string 'Wrong input!'
        end
      end

      context 'inputing additional request vectors' do
        before(:each) do
          run 'bin/deadlock exec sys_config.txt', interactive: true,
                                                  exit_timeout: 0.5
        end

        let(:multiple_inputs) do
          <<~OUTPUT
            SAFE
            Request Vector: 1 0 2
            GRANTED
            Request Vector: 1 0 2
            GRANTED
            Request Vector: 9 9 9
            NOT GRANTED
            Request Vector: 1 0 21
            Wrong input!
            Request Vector:
          OUTPUT
        end

        it 'continually asks for more request vectors' do
          type '1 0 2'
          type '1 0 2'
          type '9 9 9'
          type '1 0 21'
          expect(last_command_started).to have_output \
            include_output_string multiple_inputs
        end
      end
    end
  end
end
