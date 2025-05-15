class SearchesController < ApplicationController
  def search
    # 応急処置的に変数を@tasksにしているが改良必要
    # searchメソッド自体をindexアクションに打ち込む
    # だがindexの役割が多くなり複雑化するため要検討
    @tasks = Task.where('title LIKE ?', "%#{params[:title]}%")
    render 'tasks/index'
  end
end
