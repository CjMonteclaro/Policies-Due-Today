Octopus.using(:shard_two) do
  ["superadmin", "admin", "approver", "manager", "supervisor", "staff"].each do |role|
    Role.find_or_create_by(name: role)

  ["Chairman", "President", "SVP", "VP", "AVP", "Supervisor", "Manager", "Regular User"].each do |rank|
    Rank.find_or_create_by(name: rank, from: Date.today, to: " ")

  end
end
