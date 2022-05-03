# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

pay_rate_1 = PayRate.create(rate_name_char: 'Rate 1', base_rate_per_client: 5.0)
PayRateBonus.create(pay_rate: pay_rate_1, min_client_count: 25, rate_per_client: 3.0)

pay_rate_2 = PayRate.create(rate_name_char: 'Rate 2', base_rate_per_client: 5.0)
PayRateBonus.create(pay_rate: pay_rate_2, min_client_count: 25, max_client_count: 40, rate_per_client: 3.0)