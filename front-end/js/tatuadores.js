// ============================================================
// frontend/js/tatuadores.js
// CRUD de tatuadores + gerenciamento dos estilos
// ============================================================

// Endereço da API backend
const API = 'http://127.0.0.1:8000'

// Elementos do formulário
const formTatuador = document.getElementById('form-tatuador')
const botaoSubmit = document.getElementById('btn-submit-tatuador')

// ============================================================
// LIMPAR FORMULÁRIO
// ============================================================

function limparFormulario() {
  formTatuador.reset()

  delete formTatuador.dataset.idTatuador

  // Desmarca todos os estilos
  document.querySelectorAll('#lista-estilos input').forEach(cb => {
    cb.checked = false
  })

  botaoSubmit.textContent = 'Cadastrar'
  botaoSubmit.classList.remove('btn-success')
  botaoSubmit.classList.add('btn-primary')
}

// ============================================================
// CARREGAR SENIORIDADES
// ============================================================

async function carregarSenioridades() {
  try {
    const resposta = await fetch(`${API}/senioridade`)

    if (!resposta.ok) {
      throw new Error('Não foi possível carregar as senioridades.')
    }

    const senioridades = await resposta.json()

    const select = document.getElementById('idsenioridade')
    select.innerHTML = '<option value="">Senioridade...</option>'

    senioridades.forEach(s => {
      const opcao = document.createElement('option')
      opcao.value = s.idsenioridade
      opcao.textContent = s.nome
      select.appendChild(opcao)
    })
  } catch (erro) {
    console.error('Erro ao carregar senioridades:', erro)
    alert('Não foi possível carregar as senioridades.')
  }
}

// ============================================================
// CARREGAR ESTILOS E CRIAR CHECKBOXES
// ============================================================

async function carregarEstilos() {
  try {
    const resposta = await fetch(`${API}/estilos`)

    if (!resposta.ok) {
      throw new Error('Não foi possível carregar os estilos.')
    }

    const estilos = await resposta.json()

    const lista = document.getElementById('lista-estilos')
    lista.innerHTML = ''

    estilos.forEach(e => {
      // Cria o checkbox
      const div = document.createElement('div')
      div.className = 'form-check'

      const checkbox = document.createElement('input')
      checkbox.className = 'form-check-input'
      checkbox.type = 'checkbox'
      checkbox.value = e.idestilo
      checkbox.id = `estilo-${e.idestilo}`

      const label = document.createElement('label')
      label.className = 'form-check-label'
      label.htmlFor = checkbox.id
      label.textContent = e.descricao

      div.appendChild(checkbox)
      div.appendChild(label)
      lista.appendChild(div)
    })
  } catch (erro) {
    console.error('Erro ao carregar estilos:', erro)
    alert('Não foi possível carregar os estilos. Verifique o backend.')
  }
}

// Carrega os dados ao abrir a página
carregarSenioridades()
carregarEstilos()

// ============================================================
// LISTAR TATUADORES
// ============================================================

async function listarTatuadores() {
  try {
    const resposta = await fetch(`${API}/tatuadores`)

    if (!resposta.ok) {
      throw new Error('Não foi possível listar os tatuadores.')
    }

    const tatuadores = await resposta.json()

    const corpo = document.getElementById('corpo-tabela')
    corpo.innerHTML = ''

    tatuadores.forEach(t => {
      const linha = document.createElement('tr')

      // Cria as células com os dados
      ;[
        t.idtatuador,
        t.nometatuador,
        t.cpf,
        t.email ?? '-',
        t.telefone ?? '-',
        t.senioridade
      ].forEach(valor => {
        const td = document.createElement('td')
        td.textContent = valor
        linha.appendChild(td)
      })

      // Célula das ações
      const acoes = document.createElement('td')

      const botaoEditar = document.createElement('button')
      botaoEditar.type = 'button'
      botaoEditar.className = 'btn btn-sm btn-warning me-2'
      botaoEditar.textContent = 'Editar'
      botaoEditar.addEventListener('click', () => {
        preencherFormularioEdicao(t)
      })

      const botaoExcluir = document.createElement('button')
      botaoExcluir.type = 'button'
      botaoExcluir.className = 'btn btn-sm btn-danger'
      botaoExcluir.textContent = 'Excluir'
      botaoExcluir.addEventListener('click', () => {
        deletarTatuador(t.idtatuador)
      })

      acoes.appendChild(botaoEditar)
      acoes.appendChild(botaoExcluir)
      linha.appendChild(acoes)

      corpo.appendChild(linha)
    })
  } catch (erro) {
    console.error('Erro ao listar tatuadores:', erro)
    alert('Não foi possível carregar os tatuadores.')
  }
}

// Carrega a tabela ao abrir a página
listarTatuadores()

// ============================================================
// CADASTRAR E ATUALIZAR TATUADORES + SALVAR ESTILOS
// ============================================================

formTatuador.addEventListener('submit', async (e) => {
  e.preventDefault()

  const tatuador = {
    nometatuador: document.getElementById('nometatuador').value,
    cpf: document.getElementById('cpf').value,
    email: document.getElementById('email').value || null,
    telefone: document.getElementById('telefone').value || null,
    datacontratacao: new Date().toISOString().split('T')[0],
    idsenioridade: Number(
      document.getElementById('idsenioridade').value
    )
  }

  const idTatuador = formTatuador.dataset.idTatuador
  let idParaEstilos = idTatuador

  try {
    if (idTatuador) {
      // Atualiza o tatuador existente
      const resposta = await fetch(
        `${API}/tatuadores/${idTatuador}`,
        {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(tatuador)
        }
      )

      if (!resposta.ok) {
        throw new Error('Não foi possível atualizar o tatuador.')
      }
    } else {
      // Cadastra um novo tatuador
      const resposta = await fetch(`${API}/tatuadores`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(tatuador)
      })

      if (!resposta.ok) {
        throw new Error('Não foi possível cadastrar o tatuador.')
      }

      const dados = await resposta.json()

      // Recupera o ID gerado pelo MySQL
      idParaEstilos = dados.idtatuador

      if (!idParaEstilos) {
        throw new Error('A API não retornou o ID do novo tatuador.')
      }
    }

    // Reúne os IDs dos checkboxes marcados
    const idsMarcados = Array.from(
      document.querySelectorAll('#lista-estilos input:checked')
    ).map(checkbox => Number(checkbox.value))

    // Salva os estilos numa segunda chamada à API
    const respostaEstilos = await fetch(
      `${API}/tatuadores/${idParaEstilos}/estilos`,
      {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          idestilos: idsMarcados
        })
      }
    )

    if (!respostaEstilos.ok) {
      throw new Error('O tatuador foi salvo, mas houve erro ao salvar os estilos.')
    }

    alert(
      idTatuador
        ? 'Tatuador atualizado com sucesso!'
        : 'Tatuador cadastrado com sucesso!'
    )

    limparFormulario()
    await listarTatuadores()
  } catch (erro) {
    console.error('Erro ao salvar tatuador:', erro)
    alert(erro.message || 'Ocorreu um erro ao salvar o tatuador.')
  }
})

// ============================================================
// EDITAR TATUADOR E MARCAR OS ESTILOS JÁ CADASTRADOS
// ============================================================

async function preencherFormularioEdicao(tatuador) {
  // Preenche os campos do formulário
  document.getElementById('nometatuador').value =
    tatuador.nometatuador

  document.getElementById('cpf').value =
    tatuador.cpf

  document.getElementById('email').value =
    tatuador.email || ''

  document.getElementById('telefone').value =
    tatuador.telefone || ''

  document.getElementById('idsenioridade').value =
    tatuador.idsenioridade

  formTatuador.dataset.idTatuador = tatuador.idtatuador

  // Desmarca todos os estilos primeiro
  document.querySelectorAll('#lista-estilos input').forEach(cb => {
    cb.checked = false
  })

  try {
    // Busca os estilos associados a esse tatuador
    const resposta = await fetch(
      `${API}/tatuadores/${tatuador.idtatuador}/estilos`
    )

    if (!resposta.ok) {
      throw new Error('Não foi possível carregar os estilos do tatuador.')
    }

    const estilosDoTatuador = await resposta.json()

    // Marca os checkboxes correspondentes aos estilos encontrados
    estilosDoTatuador.forEach(e => {
      const checkbox = document.getElementById(`estilo-${e.idestilo}`)

      if (checkbox) {
        checkbox.checked = true
      }
    })

    botaoSubmit.textContent = 'Salvar alteração'
    botaoSubmit.classList.remove('btn-primary')
    botaoSubmit.classList.add('btn-success')

    // Leva o formulário para a área visível
    formTatuador.scrollIntoView({
      behavior: 'smooth',
      block: 'start'
    })
  } catch (erro) {
    console.error('Erro ao carregar estilos do tatuador:', erro)
    alert('Não foi possível carregar os estilos desse tatuador.')
  }
}

// ============================================================
// EXCLUIR TATUADOR
// ============================================================

async function deletarTatuador(id) {
  if (!confirm('Tem certeza que deseja excluir este tatuador?')) {
    return
  }

  try {
    const resposta = await fetch(`${API}/tatuadores/${id}`, {
      method: 'DELETE'
    })

    if (!resposta.ok) {
      throw new Error('Não foi possível excluir o tatuador.')
    }

    const dados = await resposta.json()

    if (dados.erro) {
      alert(dados.erro)
      return
    }

    alert('Tatuador excluído com sucesso!')

    if (formTatuador.dataset.idTatuador === String(id)) {
      limparFormulario()
    }

    await listarTatuadores()
  } catch (erro) {
    console.error('Erro ao excluir tatuador:', erro)
    alert(erro.message || 'Ocorreu um erro ao excluir o tatuador.')
  }
}