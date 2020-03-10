shared_context 'an object that has a secure random code start up' do |*methods|
  methods.each do |method|
    describe "##{method}" do
      let(:user) { build(:user, method => nil) }

      context "when the user does not have a #{method}" do
        it do
          expect { user.public_send("start_#{method}") }.to change(user, method)
        end
      end

      context "when the user has a #{method}" do
        let(:user) { build(:user, method => 'aaaa') }

        it do
          expect { user.public_send("start_#{method}") }.not_to change(user, method)
        end
      end
    end
  end
end
