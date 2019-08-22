class AddUsers < ActiveRecord::Migration[4.2]

        def change
            create_table :users do |t|
                t.string :userName
                # t.string :ticketName
            end
        end

end