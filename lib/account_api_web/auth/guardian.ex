defmodule AccountApiWeb.Auth.Guardian do
  use Guardian, otp_app: :account_api
  alias AccountApi.Accounts

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :no_id}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_account!(id) do
      account -> {:ok, account}
      _ -> {:error, :account_not_found}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :no_id}
  end

  def authenticate(email, password) do
    case Accounts.get_account_by_email(email) do
      nil -> {:error, :account_not_found}
      account ->
        case validate_password(password, account.hashed_password) do
          true -> create_token(account)
          _ -> {:error, :unauthorized}
        end
    end
  end

  defp validate_password(password, hashed_password) do
    Bcrypt.verify_pass(password, hashed_password)
  end

  defp create_token(account) do
    {:ok, token, _claims} = encode_and_sign(account)
    {:ok, account, token}
  end
end
