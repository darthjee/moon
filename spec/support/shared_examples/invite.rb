shared_context 'an object that has a secure random code start up' do |*methods|
  methods.each do |method|
    describe "##{method}" do
      let(:marriage) { create(:marriage) }
      let(:invite) { build(:invite, method => nil, marriage_id: marriage.id) }

      context "when the invite does not have a #{method}" do
        it do
          expect { invite.public_send("start_#{method}") }.to change(invite, method)
        end
      end

      context "when the invite has a #{method}" do
        let(:invite) { build(:invite, method => 'aaaa', marriage_id: marriage.id) }

        it do
          expect { invite.public_send("start_#{method}") }.not_to change(invite, method)
        end
      end
    end
  end
end
