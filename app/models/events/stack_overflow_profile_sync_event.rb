class StackOverflowProfileSyncEvent < SyncEvent

  referenced_in :stack_overflow_profile, :inverse_of => :events

  def earn_points
    rep_points = stack_overflow_profile.reputation / 100
    stack_overflow_profile.profile.adjust_score("StackOverflow reputation", rep_points, :knowledge_points)
  end

  def sync
    return if stack_overflow_profile.stack_overflow_id.nil?
    
    user = StackOverflow.get_user(stack_overflow_profile.stack_overflow_id)
    stack_overflow_profile.profile.name = user["display_name"] if stack_overflow_profile.profile.name.nil?
    stack_overflow_profile.url = "http://www.stackoverflow.com/users/#{stack_overflow_profile.stack_overflow_id}"
    stack_overflow_profile.reputation = user["reputation"]
    stack_overflow_profile.badge_html = user["badgeHtml"]
    tags = StackOverflow.get_user_tags(stack_overflow_profile.stack_overflow_id)
    so_tags = {}
    tags["tags"].each do |t|
      so_tags[t["name"]] = t["count"]
    end
    stack_overflow_profile.stack_overflow_tags = so_tags.to_yaml

    sync_questions
    sync_answers

    stack_overflow_profile.profile.save!
    stack_overflow_profile.save!

    stack_overflow_profile.retag!
  end

  def award_badges
    if stack_overflow_profile.reputation > 10000
      profile.award_badge("I'm kind of a Big Deal", :description => "For having a StackOverflow reputation over 10k")
    end
  end

  def sync_questions
    questions = StackOverflow.get_user_questions(stack_overflow_profile.stack_overflow_id)

    top_questions = questions.sort{|a,b| a["score"] <=> b["score"] }.first(3)

    top_questions.each do |so_question|
      question = stack_overflow_profile.questions.where(:question_id => so_question["question_id"]).first
      unless question
        question = stack_overflow_profile.questions.build
      end
      question.title = so_question["title"]
      question.question_id = so_question["question_id"]
      question.url = "http://www.stackoverflow.com/questions/#{so_question["question_id"]}"
      question.date = Time.at(so_question["creation_date"])
      question.score = so_question["score"]
      question.save
    end

    top_question_ids = top_questions.map{|q| q["question_id"]}
    questions_to_delete = stack_overflow_profile.questions.not_in(:question_id => top_question_ids)
    questions_to_delete.each{|q| q.destroy }
  end
  
  def convert_to_date(value)
    if (value.class == String)
      value = value.sub(" ","").to_i
    end
    Time.at(value)
  end

  def sync_answers
    answers = StackOverflow.get_user_answers(stack_overflow_profile.stack_overflow_id)

    top_answers = answers.sort{|a,b| a["score"] <=> b["score"] }.first(3)

    top_answers.each do |so_answer|
      answer = stack_overflow_profile.answers.where(:answer_id => so_answer["answer_id"]).first
      unless answer
        answer = stack_overflow_profile.answers.build
      end
      answer.title = so_answer["title"]
      answer.question_id = so_answer["question_id"]
      answer.answer_id = so_answer["answer_id"]
      answer.accepted = so_answer["accepted"]
      answer.url = "http://www.stackoverflow.com/questions/#{so_answer["question_id"]}"

      answer.date = convert_to_date(so_answer["creation_date"])
      answer.score = so_answer["score"]
      answer.save
    end

    top_answer_ids = top_answers.map{|a| a["answer_id"]}
    answers_to_delete = stack_overflow_profile.answers.not_in(:answer_id => top_answer_ids)
    answers_to_delete.each{|a| a.destroy }
  end

end
