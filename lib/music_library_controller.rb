class MusicLibraryController
  def initialize(path = "./db/mp3s")
    import_obj = MusicImporter.new(path)
    import_obj.import
  end

  def call
    input = ""
    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.strip

      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
    end
  end

  def list_songs
    sorted_list = Song.all.sort_by{|song| song.name}
    sorted_list.each_with_index do |song, i|
      puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    sorted_list = Artist.all.sort_by {|artist| artist.name}
    sorted_list.each_with_index do |artist, i|
      puts "#{i + 1}. #{artist.name}"
    end
  end

  def list_genres
    sorted_list = Genre.all.sort_by {|genre| genre.name}
    sorted_list.each_with_index do |genre, i|
      puts "#{i + 1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = ""
    input = gets.chomp

    selection = Artist.find_by_name(input)
    if selection
      song_list = selection.songs.sort_by{|song| song.name}
      song_list.each_with_index do |song, i|
        puts "#{i + 1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = ""
    input = gets.strip

    selection = Genre.find_by_name(input)
    if selection
      song_list = selection.songs.sort_by{|song| song.name}
      song_list.each_with_index do |song, i|
        puts "#{i + 1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = ""
    input = gets.strip.to_i

    song_list = Song.all.sort_by{|song| song.name}
    if input.between?(1, song_list.size)
      puts "Playing #{song_list[input-1].name} by #{song_list[input-1].artist.name}"
    end
  end
end
