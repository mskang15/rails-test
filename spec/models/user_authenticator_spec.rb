require_relative '../../app/models/user_authenticator'
require 'bcrypt'
describe UserAuthenticator do
	let(:user) { double('User') }
	let(:password) {'secure1234' }
	let(:crypted_password) {BCrypt::Password.create(password).to_s}
	let(:wrong_password) {'wrong'}

	it "can authenticate a user" do
		user.stub(:password).and_return crypted_password
		auth = UserAuthenticator.new user
		expect(auth.authenticate(password)).to eql user
		expect(auth.authenticate(wrong_password)).to eql false
	end

	it "returns false when user is nil" do
		user.stub(:password).and_return password
		auth = UserAuthenticator.new nil
		expect(auth.authenticate(nil)).to eql false
	end
end