require 'spec_helper'
require 'apralib'

module ApraService

  describe 'Grantee' do

    describe 'verify_ssn' do

      it 'should return true when the ssn is valid' do
        Grantee.verify_ssn('111111-111C').should be_true
      end


    end

    describe 'verify_ssn!' do

      it 'should not throw any exception when the ssn is valid' do
        expect{Grantee.verify_ssn!('111111-111C')}.not_to raise_error
      end

    end

  end

end