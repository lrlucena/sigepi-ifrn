package controllers;

import helpers.Seguranca.Permissao;

import java.util.List;

import models.AreaConhecimento;
import models.Campus;
import play.data.Form;
import play.mvc.Controller;
import play.mvc.Result;

/**
 * Crud de Área de Conhecimento.
 * 
 * @author Alessandro
 *
 */
public class AreaConhecimentoController extends Controller {

	/**
	 * Método de início irá listas todas as áreas de conhecimento.
	 *
	 * @return as áreas renderizadas.
	 */
	public static Result index() {
		List<AreaConhecimento> areas = AreaConhecimento.find.findList();
		return ok(views.html.AreaConhecimento.index.render(areas));
	}

	/**
	 * Visualizar uma área de conhecimento.
	 *
	 * @param id
	 * @return uma área de conhecimento.
	 */
	public static Result visualizar(Long id) {

		AreaConhecimento area = AreaConhecimento.find.byId(id);
		if(area == null){
			flash().put("error", "A Área informada não foi encontrada no Sistema.");
			return redirect(routes.AreaConhecimentoController.index());
		}
		return ok(views.html.AreaConhecimento.visualizar.render(area));
	}
	
	/**
	 * Abrir o formulario do cadastro de nova área de conhecimento.
	 *
	 * @return
	 */
	@Permissao("Administrador")
	public static Result formulario() {	
		return ok(views.html.AreaConhecimento.formulario.render(form(AreaConhecimento.class)));
	}
	
	/**
	 * Cadastra uma nova área de conhecimento.
	 *
	 * @return
	 */
	@Permissao("Administrador")
	public static Result cadastrar() {

		Form<AreaConhecimento> form = form(AreaConhecimento.class).bindFromRequest();

		if (form.hasErrors()) {
			flash().put("error",
					"Você deve preencher o campo corretamente. Tente novamente!");
			return badRequest(views.html.AreaConhecimento.formulario.render(form));
		}

		AreaConhecimento area = form.get();
		area.save();

		flash().put("success", "Área \"" + area.nome + "\" Cadastrado com Sucesso!");

		return redirect(routes.AreaConhecimentoController.index());
	}

	/**
	 * Atualiza uma área de conhecimento.
	 *
	 * @param id o id da area de conhecimento
	 * @return
	 */
	@Permissao("Administrador")
	public static Result editar(Long id) {

		Form<AreaConhecimento> form = form(AreaConhecimento.class).bindFromRequest();
		AreaConhecimento area = AreaConhecimento.find.byId(id);

		if (form.hasErrors()) {
			flash().put("error",
					"Você deve preencher todos os campos corretamente. Tente novamente!");
			return badRequest(views.html.AreaConhecimento.formularioEdicao.render(form.fill(form.get()), area));
		}

		area.setNome(form.get().nome);
		area.update();

		flash().put("success",	"Área \"" + area.nome + "\" atualizado com sucesso!");
		return redirect(routes.AreaConhecimentoController.index());
	}

	/**
	 * Abre um formulário para a atualização da área de conhecimento.
	 *
	 * @param id o id da área de conhecimento
	 * @return
	 */
	@Permissao("Administrador")
	public static Result formularioEdicao(Long id) {
		AreaConhecimento area = AreaConhecimento.find.byId(id);
		if(area == null){
			flash().put("error", "A Área informada não foi encontrada no Sistema.");
			return redirect(routes.AreaConhecimentoController.index());
		}
		return ok(views.html.AreaConhecimento.formularioEdicao.render(form(AreaConhecimento.class).fill(area), area));
	}

	/**
	 * Exlui uma área de conhecimento da base de dados.
	 *
	 * @param id o id da área de conhecimento
	 * @return
	 */
	@Permissao("Administrador")
	public static Result deletar(Long id) {
		AreaConhecimento area = AreaConhecimento.find.byId(id);
		if (area == null) {
			flash().put("error", "A Área informada não foi encontrada no Sistema.");
		} else if(area.usuarios.size() > 0){
			flash().put("error", "A Área de Conhecimento não pode ser excluída, pois existem outros objetos impedindo a sua exclusão!");
		}else {
			area.delete();
			flash().put("success", "Área \"" + area.nome + "\" excluída com sucesso!");
		}
		return redirect(routes.AreaConhecimentoController.index());
	}
}
