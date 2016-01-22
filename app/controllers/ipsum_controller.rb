class IpsumController < ApplicationController

  def index
    @ipsum = "<center><p>Customize the options above and click 'Generate'.</p></center>"
    @default_options = [5, 'medium', true]
    if session[:new_ipsum]
      @ipsum = generate_ipsum(session[:new_ipsum][0], session[:new_ipsum][1], session[:new_ipsum][2])
      @default_options = session[:new_ipsum]
      session[:new_ipsum] = nil
    end
  end

  def generate
    param = params[:ipsum_generator]
    p_num_paragraphs = param['num_paragraphs'].to_i
    p_paragraph_size = param['paragraph_size']
    if param['start_with_default'] == '0'
      p_start_with_default = false
    else
      p_start_with_default = true
    end
    # Pass the selected options to a cookie that the index action can read
    session[:new_ipsum] = [p_num_paragraphs, p_paragraph_size, p_start_with_default]
    redirect_to(:controller => 'ipsum', :action => 'index')
  end

  private

    def generate_ipsum(paragraphs, length, start_with_default = true)
      # Generate HTML paragraphs from listed words chosen at random
      #
      # Version 1.21
      # Created by Ceres Unrau for Chocolate Milk Ipsum
      # Feel free to use with citation. If you use it, I'd love to know <3 ceres@unrau.me
      #
      # Valid lengths are the following strings:
      # 'short'
      # 'medium'
      # 'long'
      #

      # Options
      max_paragraph_num = 20

      # This is the main list of words to be placed randomly into the paragraphs
      ipsum_words = [
        'chocolate',
        'milk',
        'brown',
        'cow',
        'drinking',
        'sipping',
        'delicious',
        'enjoy',
        'creamy',
        'sweet',
        'rich',
        'chocolaty',
        'milky',
        'home made',
        'perfect',
        'syrup',
        'chocolate milk',
        'taste'
      ]

      # This is a list of rare words that have only 1 in 50 chance of appearing
      rare_words = [
        'nectar of the gods',
        'the one true chocolate milk',
        'yum yum',
        'favourite',
        'craving',
        'sinful',
        'wow'
      ]

      # This is a list of words that exist to make sentences sound more natural
      natural_words = [
        'and',
        'with',
        'very',
        'absolutely',
        'to',
        'for',
        'in',
        'this',
        'is',
        'like'
      ]

      # Set the minimum number of sentences per paragraph based on the length parameter
      length_min = 0
      case length.downcase
      when 'short'
        length_min = 2
      when 'medium'
        length_min = 5
      when 'long'
        length_min = 10
      else
        length_min = 5
      end

      # Initialize the ipsum text
      ipsum = '<p>'

      # Allow choice of whether ipsum starts with default text
      if start_with_default
        ipsum.concat 'Chocolate milk ipsum'
      end

      # Limit the amount of paragraphs to the maximum
      if paragraphs > max_paragraph_num
        paragraphs = max_paragraph_num
        ipsum = "<center><p style='font-size:0.7em;' class='col-red'>Result has been limited to #{max_paragraph_num} paragraphs.<em></em></p></center>#{ipsum}"
      end

      p_count = 0
      for paragraph in (1..paragraphs)
        # Initialize a new paragraph
        par = ''

        # Chose a random number of sentences between the minimum and twice the minimum
        num_sentences = length_min + Random.rand(length_min)

        s_count = 0
        for sentence in (1..num_sentences)
          w_count = 0
          for word in (1..Random.rand(3..20))
            # Initialize a new word
            new_word = ''

            # A random word is seldom selected from the rare word list
            if Random.rand(50) == 1
              new_word = rare_words[Random.rand(rare_words.size)]
            # A random word is sometimes selected from the natural sentence word list,
            # as long as the previous word is not one of these words
            elsif Random.rand(10) == 1 && !natural_words.include?(par.split.last)
              new_word = natural_words[Random.rand(natural_words.size)]
            # A random word is selected from the main word list
            else
              new_word = ipsum_words[Random.rand(ipsum_words.size)]
            end

            # Eliminate duplicate consecutive words
            last_word = par.split.last.to_s
            while new_word.downcase == last_word.downcase
              new_word = ipsum_words[Random.rand(ipsum_words.size)]
            end

            # First word after the optional default text starts with a space and is not capitalized
            if p_count == 0 && s_count == 0 && w_count == 0 && start_with_default
              new_word = ' ' + new_word
            # First word of a normal paragraph doesn't start with a space and is capitalized
            elsif p_count != 0 && s_count == 0 && w_count == 0
              new_word = new_word[0].upcase + new_word[1..-1]
            # First word of a sentence is capitalized
            elsif w_count == 0
              new_word = ' ' + new_word[0].upcase + new_word[1..-1]
            # all other words just have a space added in front
            else
              new_word = ' ' + new_word
            end

            # Words can sometimes be followed by a comma to simulate a typcial sentence structure
            # Words in the natural sentence list cannot be followed by a comma.
            if Random.rand(10) == 1 && !natural_words.include?(new_word.strip)
              new_word.concat ','
            end

            # Add the new word to the paragraph
            par.concat new_word

            w_count += 1
          end

          # Ensure the new sentence does not end with one of the natural sentence words
          while natural_words.include?(par.split.last)
            bad_word = par.split.last
            par = par[0..-(bad_word.size + 2)]
          end

          # Ensure the new sentence ends with a period, replacing any ending comma
          if par[-1] == ','
            par = par[0..-2] + '.'
          else
            par.concat '.'
          end

          s_count += 1
        end

        # Only start a new paragraph if this isn't the first paragraph
        # The ipsum text starts with a new paragraph by default
        # This allows the default text to be the first part of the first paragraph
        if p_count != 0
          ipsum.concat '<p>'
        end

        # Add the new paragraph to the ipsum text
        ipsum.concat par
        ipsum.concat '</p>'

        p_count += 1
      end

      return ipsum
    end

end
