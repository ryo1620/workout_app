require "rails_helper"

RSpec.describe ContactMailer, type: :mailer do
  describe "contact_mail" do
    let(:contact) { build(:contact) }
    let(:mail) { ContactMailer.contact_mail(contact) }

    it "renders the headers" do
      expect(mail.subject).to eq("お問い合わせ")
      expect(mail.to).to eq([Rails.application.credentials.gmail[:user_name]])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded.force_encoding("UTF-8").split(/\r\n/).map{|i| Base64.decode64(i)}.join).to match(contact.email)
    end
  end

end
