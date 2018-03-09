class AddFunctionStriptags < ActiveRecord::Migration[5.1]
  def up
    connection.execute(%q{
      CREATE OR REPLACE FUNCTION strip_tags(TEXT) RETURNS TEXT AS $$
          SELECT regexp_replace(
              regexp_replace($1,
                 E'<[^>]*?(\s* href \s* = \s* ([\'"]) ([^>]*?) ([\'"]) ) [^>]*?>',
                 E' (\\3) ',
                  'gx'),
              E'(< [^>]*? >)',
              E'',
               'gx')
      $$ LANGUAGE SQL;
    })
  end

  def down
    connection.execute(%q{ DROP FUNCTION IF EXISTS strip_tags() })
  end
end
