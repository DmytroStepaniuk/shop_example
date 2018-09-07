require 'rails_helper'

RSpec.describe SignIn do
  subject { SignIn.new email: 'lol@kek.com', password: '123456' }

  describe '#user' do
    before { expect(User).to receive(:find_by).with(email: 'lol@kek.com').and_return(:user) }

    its(:user) { should eq :user }
  end

  describe '#session' do
    before { expect(subject).to receive_message_chain(:user, :sessions, :create!).and_return(:session) }

    its(:session) { should eq :session }
  end

  describe '#password?' do
    let(:user) { double }

    before { expect(subject).to receive(:user).and_return(user) }

    context do
      before { expect(user).to receive(:authenticate).with('123456').and_return(true) }

      its(:password?) { should eq true }
    end

    context do
      before { expect(user).to receive(:authenticate).with('123456').and_return(false) }

      its(:password?) { should eq false }
    end
  end

  describe '#valid?' do
    let(:sign_in) { SignIn.new email: 'lol@kek.com', password: '123456' }

    subject { sign_in.errors }

    context do
      before { expect(sign_in).to receive(:user) }

      before { sign_in.valid? }

      its([:email]) { should eq ['not found'] }
    end

    context do
      before { expect(sign_in).to receive(:user).and_return(:user) }

      before { expect(sign_in).to receive(:password?).and_return(false) }

      before { sign_in.valid? }

      its([:password]) { should eq ['is invalid'] }
    end
  end

  describe '#save!' do
    context do
      before { expect(subject).to receive(:valid?).and_return(false) }

      it { expect { subject.save! }.to raise_error ActiveModel::StrictValidationFailed }
    end

    context do
      let(:user) { double }

      before { expect(subject).to receive(:valid?).and_return(true) }

      before { expect(subject).to receive(:session) }

      it { expect { subject.save! }.to_not raise_error ActiveModel::StrictValidationFailed }
    end
  end
end
