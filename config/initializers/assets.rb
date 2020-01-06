# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.

Rails.application.config.assets.paths << Rails.root.join('node_modules')
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( DataTables/datatables.css DataTables/datatables.js pdf.css.scss Config.js kendo.dataviz.min.js jquery.ticker.js slider.css user_dashboard.css dynamicuser.js papaparse.js js.cookie.js nicEdit.js papaparse.css demo.js demo.css pagination.css validator.css validator.js calendar.js )
# jquery.dataTables.min.css 
# buttons.html5.min.js
# dtbuttons.min.js
# buttons.dataTables.css 
# buttons.dataTables.js 
# buttons.bootstrap4.min.js 
# buttons.bootstrap4.min.css 
# dataTables.select.min.js 
# datatables.min.js 
# jquery.dataTables.min.js 
# datatables.min.css
# select.bootstrap4.min.css 
# select.bootstrap4.min.js 
# select.dataTables.min.css 
# dataTables.select.min.js 
# select.bootstrap4.js 
# select.foundation.min.js 
# select.dataTables.js