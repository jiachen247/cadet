defmodule CadetWeb.GradingController do
  use CadetWeb, :controller

  use PhoenixSwagger

  swagger_path :index do
    get("/grading")

    summary("Get a list of all submissions with current user as the grader. ")

    security([%{JWT: []}])

    produces("application/json")

    parameters do
      filter(:query, :string, "Filter only specific types e.g. done/pending")
    end

    response(200, "OK", Schema.ref(:Submissions))
    response(401, "Unauthorised")
  end

  swagger_path :show do
    get("/grading/{submissionId}")

    summary("Get information about a specific submission to be graded.")

    security([%{JWT: []}])

    produces("application/json")

    parameters do
      submissionId(:path, :integer, "submission id", required: true)
    end

    response(200, "OK", Schema.ref(:GradingInfo))
    response(400, "Invalid or missing parameter(s) or submission and/or question not found")
    response(401, "Unauthorised")
  end

  swagger_path :update do
    post("/grading/{submissionId}/{questionId}")

    summary(
      "Update comment and/or marks given to the answer of a particular querstion in a submission"
    )

    security([%{JWT: []}])

    consumes("application/json")
    produces("application/json")

    parameters do
      submissionId(:path, :integer, "submission id", required: true)
      questionId(:path, :integer, "question id", required: true)
      grading(:body, Schema.ref(:Grade), "comment given for a question", required: true)
    end

    response(200, "OK")
    response(400, "Invalid or missing parameter(s) or submission and/or question not found")
    response(401, "Unauthorised")
  end

  def swagger_definitions do
    %{
      Submissions:
        swagger_schema do
          type(:array)
          items(Schema.ref(:Submission))
        end,
      Submission:
        swagger_schema do
          properties do
            submissionId(:integer, "submission id", required: true)
            missionId(:integer, "mission id", required: true)
            studentId(:integer, "student id", required: true)
          end
        end,
      GradingInfo:
        swagger_schema do
          description(
            "A list of questions with submitted answers and previous grading info if available"
          )

          type(:array)

          items(
            Schema.new do
              properties do
                question(Schema.ref(:Question))
                grade(Schema.ref(:Grade))
                max_xp(:integer, "the max xp that can be given to this question", required: true)
              end
            end
          )
        end,
      Grade:
        swagger_schema do
          properties do
            comment(:string, "comment given")
            xp(:integer, "xp given")
          end
        end
    }
  end
end
