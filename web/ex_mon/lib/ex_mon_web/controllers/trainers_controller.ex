defmodule ExMonWeb.TrainersController do
  use ExMonWeb, :controller

  alias ExMonWeb.Auth.Guardian

  action_fallback(ExMonWeb.FallbackController)

  def create(conn, params) do
    with {:ok, trainer} <- ExMon.create_trainer(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(trainer) do
      conn
      |> put_status(:created)
      |> render("create.json", %{trainer: trainer, token: token})
    end
  end

  def delete(conn, %{"id" => id}) do
    id
    |> ExMon.delete_trainer()
    |> handle_delete(conn)
  end

  def show(conn, %{"id" => id}) do
    id
    |> ExMon.fecth_trainer()
    |> handle_response(conn, "show.json", :ok)
  end

  # def show_all(conn, _params) do
  #   trainers = ExMon.Repo.all(ExMon.Trainer)

  #   conn
  #   |> put_status(200)
  #   |> render("show_all.json", trainers: trainers)
  # end

  def update(conn, params) do
    params
    |> ExMon.update_trainer()
    |> handle_response(conn, "update.json", :ok)
  end

  defp handle_delete({:ok, _trainer}, conn) do
    conn
    |> put_status(:no_content)
    |> text("Deletado com Sucesso")
  end

  defp handle_delete({:error, _reason} = error, _conn), do: error

  defp handle_response({:ok, trainer}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, trainer: trainer)
  end

  defp handle_response({:error, _changeset} = error, _conn, _view, _status), do: error
end
