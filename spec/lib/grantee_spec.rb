require 'spec_helper'
require 'apralib'

module ApraService

  describe 'Grantee' do

    describe 'verify_ssn' do

      it 'should return true when the ssn is valid' do
        expect(Grantee.verify_ssn('111111-111C')).to be_truthy
      end


    end

    describe 'verify_ssn!' do

      it 'should not throw any exception when the ssn is valid' do
        expect{Grantee.verify_ssn!('111111-111C')}.not_to raise_error
      end

    end

    describe 'ssn=' do

      it 'should convert the code to uppercase' do

        grantee = Grantee.new
        grantee.ssn = '111111-111c'
        expect(grantee.ssn).to eq('111111-111C')

      end

      it 'should set the value to nil when passed a nil value' do

        grantee = Grantee.new
        grantee.ssn = '111111-111C'
        grantee.ssn = nil
        expect(grantee.ssn).to be_nil

      end


    end

  end

end