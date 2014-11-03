require_relative '../../app/models/user_session'

describe UserSession do |variable|
	let(:request) {double('Request')}
	let(:user) {double('User')}
	let(:finder) {double('User')}

	it 'can start a session' do	
		request.stub(:session).and_return({})
		user.stub(:id).and_return 1

		user_session = UserSession.new(request, finder)
		user_session.start_session(user)

		expect(request.session[:user_id]).to eq 1
	end
	

	it 'can destroy a session' do
		request.stub(:session).and_return({user_id: 1})
		user.stub(:id).and_return 1

		user_session = UserSession.new(request, finder)
		user_session.destroy_session

		expect(request.session[:user_id]).to eq nil
	end

	it 'can determine current user' do
		request.stub(:session).and_return({user_id: 1})
		finder.stub(:where).and_return finder
		finder.stub(:first).and_return user
		user.stub(:id).and_return 1

		user_session = UserSession.new(request, finder)

		expect(user_session.current_user).to eql user

		user_session.destroy_session
		expect(user_session.current_user).to eql nil
	end



end