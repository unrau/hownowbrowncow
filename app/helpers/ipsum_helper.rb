module IpsumHelper

  def generate_ipsum(paragraphs, length, start_with_default = true)
    # Generate HTML paragraphs of listed words chosen at random

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
      'chocolaty'
    ]

    # This is a list of rare words that have only 1 in 100 chance of appearing
    rare_words = [
      'nectar of the gods',
      'the one true',
      'ipsum',
      'yum yum',
      'tastes like'
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

    p_count = 0
    for paragraph in (1..paragraphs)
      # Initialize a new paragraph
      par = ''

      # Chose a random number of sentinces between the minimum and twice the minimum
      num_sentences = length_min + Random.rand(length_min)

      s_count = 0
      for sentence in (1..num_sentences)
        w_count = 0
        for word in (1..Random.rand(3..20))
          # Initialize a new word
          new_word = ''

          # A random word is selected that can sometimes be a rare word
          if Random.rand(100) == 1
            new_word = rare_words[Random.rand(rare_words.size)]
          else
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
          if Random.rand(10) == 1
            new_word.concat ','
          end

          # Add the new word to the paragraph
          par.concat new_word

          w_count += 1
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
