require "my_spec_helper"
require "./app/use_cases/post_create_use_case"
require "./app/domain/user"
require "./spec/doubles/persistance_double"

RSpec.describe PostCreateUseCase do
  it 'success' do
    persistance = PersistanceDouble.build
    current_user = User.build
    
    result = PostCreateUseCase.call(persistance: persistance,
                                    current_user: current_user,
                                    attributes: { title: "Best board games of 2018" })
    
    expect(result.post.title).to eq "Best board games of 2018"
    expect(persistance.post_persisted_count).to eq 1
  end 
end
